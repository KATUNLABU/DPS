-- ==============================================================================
-- SISTEMA DE BLOG, ROLES, PERMISOS Y SEGURIDAD (KATUN DPS)
-- ==============================================================================
-- Este script configura las tablas, tipos enumerados, funciones de seguridad,
-- disparadores (triggers) y políticas RLS (Row Level Security) para el Blog y su Dashboard.

-- 1. EXTENSIÓN PARA UUIDs (si no está activa)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. TIPOS ENUMERADOS
DO $$ BEGIN
    CREATE TYPE blog_user_role AS ENUM ('superadmin', 'admin', 'editor', 'author');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE blog_post_status AS ENUM ('draft', 'published', 'archived');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 3. TABLA DE PERFILES DE USUARIO Y PERMISOS (blog_profiles)
-- Vinculada directamente con auth.users de Supabase
CREATE TABLE IF NOT EXISTS public.blog_profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL DEFAULT 'Usuario DPS',
    avatar_url TEXT DEFAULT '',
    role blog_user_role NOT NULL DEFAULT 'author',
    permissions JSONB NOT NULL DEFAULT '{
        "can_publish": false,
        "can_delete": false,
        "can_manage_users": false,
        "can_edit_all": false
    }'::jsonb,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 4. TABLA DE ENTRADAS DEL BLOG (blog_posts)
CREATE TABLE IF NOT EXISTS public.blog_posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    summary TEXT NOT NULL DEFAULT '',
    content_html TEXT DEFAULT '',
    -- Estructura de bloques visuales modulares ("tipo Canva")
    canvas_blocks JSONB NOT NULL DEFAULT '[]'::jsonb,
    featured_image TEXT NOT NULL DEFAULT '',
    category TEXT NOT NULL DEFAULT 'Tecnología',
    tags TEXT[] NOT NULL DEFAULT '{}',
    author_id UUID REFERENCES public.blog_profiles(id) ON DELETE SET NULL,
    author_name TEXT NOT NULL DEFAULT 'Equipo Katun DPS',
    author_avatar TEXT DEFAULT '',
    status blog_post_status NOT NULL DEFAULT 'draft',
    reading_time INTEGER NOT NULL DEFAULT 5, -- en minutos
    views_count BIGINT NOT NULL DEFAULT 0,
    seo_title TEXT DEFAULT '',
    seo_description TEXT DEFAULT '',
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 5. TABLA DE LOGS DE AUDITORÍA Y SEGURIDAD (blog_activity_logs)
CREATE TABLE IF NOT EXISTS public.blog_activity_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.blog_profiles(id) ON DELETE SET NULL,
    user_email TEXT,
    action TEXT NOT NULL, -- 'create_post', 'update_post', 'delete_post', 'change_role', 'login', etc.
    target_id TEXT,
    details JSONB DEFAULT '{}'::jsonb,
    ip_address TEXT DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 6. ÍNDICES DE RENDIMIENTO Y BÚSQUEDA
CREATE INDEX IF NOT EXISTS idx_blog_posts_slug ON public.blog_posts(slug);
CREATE INDEX IF NOT EXISTS idx_blog_posts_status ON public.blog_posts(status);
CREATE INDEX IF NOT EXISTS idx_blog_posts_category ON public.blog_posts(category);
CREATE INDEX IF NOT EXISTS idx_blog_posts_published_at ON public.blog_posts(published_at DESC);
CREATE INDEX IF NOT EXISTS idx_blog_activity_logs_created_at ON public.blog_activity_logs(created_at DESC);

-- 7. FUNCIÓN Y TRIGGER PARA ACTUALIZAR updated_at AUTOMÁTICAMENTE
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_blog_profiles_updated_at ON public.blog_profiles;
CREATE TRIGGER tr_blog_profiles_updated_at
    BEFORE UPDATE ON public.blog_profiles
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

DROP TRIGGER IF EXISTS tr_blog_posts_updated_at ON public.blog_posts;
CREATE TRIGGER tr_blog_posts_updated_at
    BEFORE UPDATE ON public.blog_posts
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- 8. TRIGGER PARA CREAR PERFIL AUTOMÁTICO EN REGISTRO DE AUTH
CREATE OR REPLACE FUNCTION public.handle_new_user_profile()
RETURNS TRIGGER AS $$
DECLARE
    is_first_user BOOLEAN;
    user_role blog_user_role;
    user_perms JSONB;
BEGIN
    -- Si es el primer usuario registrado en la plataforma, asignarle superadmin
    SELECT COUNT(*) = 0 INTO is_first_user FROM public.blog_profiles;
    
    IF is_first_user THEN
        user_role := 'superadmin';
        user_perms := '{"can_publish": true, "can_delete": true, "can_manage_users": true, "can_edit_all": true}'::jsonb;
    ELSE
        user_role := 'author';
        user_perms := '{"can_publish": false, "can_delete": false, "can_manage_users": false, "can_edit_all": false}'::jsonb;
    END IF;

    INSERT INTO public.blog_profiles (id, email, full_name, role, permissions, avatar_url)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
        user_role,
        user_perms,
        COALESCE(NEW.raw_user_meta_data->>'avatar_url', '')
    )
    ON CONFLICT (id) DO UPDATE
    SET email = EXCLUDED.email;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user_profile();

-- 9. FUNCIONES HELPER DE PERMISOS PARA RLS
CREATE OR REPLACE FUNCTION public.get_current_user_role()
RETURNS blog_user_role AS $$
    SELECT role FROM public.blog_profiles WHERE id = auth.uid() AND is_active = true;
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.is_blog_admin()
RETURNS BOOLEAN AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.blog_profiles
        WHERE id = auth.uid() 
          AND is_active = true 
          AND role IN ('superadmin', 'admin')
    );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.can_edit_post(post_author_id UUID)
RETURNS BOOLEAN AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.blog_profiles
        WHERE id = auth.uid() 
          AND is_active = true
          AND (
            role IN ('superadmin', 'admin', 'editor') 
            OR (role = 'author' AND id = post_author_id)
            OR (permissions->>'can_edit_all')::boolean = true
          )
    );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- 10. POLÍTICAS DE SEGURIDAD (ROW LEVEL SECURITY - RLS)
ALTER TABLE public.blog_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.blog_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.blog_activity_logs ENABLE ROW LEVEL SECURITY;

-- --- Políticas para blog_profiles ---
DROP POLICY IF EXISTS "Lectura pública de perfiles activos" ON public.blog_profiles;
CREATE POLICY "Lectura pública de perfiles activos"
    ON public.blog_profiles FOR SELECT
    USING (is_active = true);

DROP POLICY IF EXISTS "Usuarios pueden actualizar su propio perfil" ON public.blog_profiles;
CREATE POLICY "Usuarios pueden actualizar su propio perfil"
    ON public.blog_profiles FOR UPDATE
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

DROP POLICY IF EXISTS "Admins pueden gestionar todos los perfiles" ON public.blog_profiles;
CREATE POLICY "Admins pueden gestionar todos los perfiles"
    ON public.blog_profiles FOR ALL
    USING (public.is_blog_admin());

-- --- Políticas para blog_posts ---
DROP POLICY IF EXISTS "Público puede ver posts publicados" ON public.blog_posts;
CREATE POLICY "Público puede ver posts publicados"
    ON public.blog_posts FOR SELECT
    USING (status = 'published' OR (auth.uid() IS NOT NULL AND public.can_edit_post(author_id)));

DROP POLICY IF EXISTS "Usuarios autenticados con rol pueden crear posts" ON public.blog_posts;
CREATE POLICY "Usuarios autenticados con rol pueden crear posts"
    ON public.blog_posts FOR INSERT
    WITH CHECK (
        auth.uid() IS NOT NULL 
        AND EXISTS (SELECT 1 FROM public.blog_profiles WHERE id = auth.uid() AND is_active = true)
    );

DROP POLICY IF EXISTS "Usuarios pueden editar posts autorizados" ON public.blog_posts;
CREATE POLICY "Usuarios pueden editar posts autorizados"
    ON public.blog_posts FOR UPDATE
    USING (public.can_edit_post(author_id))
    WITH CHECK (public.can_edit_post(author_id));

DROP POLICY IF EXISTS "Admins o autores autorizados pueden eliminar posts" ON public.blog_posts;
CREATE POLICY "Admins o autores autorizados pueden eliminar posts"
    ON public.blog_posts FOR DELETE
    USING (
        public.is_blog_admin() 
        OR (
            auth.uid() = author_id 
            AND EXISTS (
                SELECT 1 FROM public.blog_profiles 
                WHERE id = auth.uid() AND (permissions->>'can_delete')::boolean = true
            )
        )
    );

-- --- Políticas para blog_activity_logs ---
DROP POLICY IF EXISTS "Admins pueden ver logs de auditoria" ON public.blog_activity_logs;
CREATE POLICY "Admins pueden ver logs de auditoria"
    ON public.blog_activity_logs FOR SELECT
    USING (public.is_blog_admin());

DROP POLICY IF EXISTS "Usuarios autenticados pueden registrar actividad" ON public.blog_activity_logs;
CREATE POLICY "Usuarios autenticados pueden registrar actividad"
    ON public.blog_activity_logs FOR INSERT
    WITH CHECK (auth.uid() IS NOT NULL);

-- 11. FUNCIÓN RPC PARA INCREMENTAR CONTADOR DE VISITAS DE FORMA SEGURA
CREATE OR REPLACE FUNCTION public.increment_post_views(target_slug TEXT)
RETURNS VOID AS $$
BEGIN
    UPDATE public.blog_posts
    SET views_count = views_count + 1
    WHERE slug = target_slug;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 12. LIMPIEZA DE ENTRADAS ANTERIORES Y REGISTRO DE ENTRADA OFICIAL (Por Aleydis Reyes)
DELETE FROM public.blog_posts WHERE slug = 'revolucion-troquelado-laser-memjet-duraflex-2026' OR author_name = 'Roberto González';

INSERT INTO public.blog_posts (
    slug,
    title,
    summary,
    featured_image,
    category,
    tags,
    author_name,
    status,
    reading_time,
    seo_title,
    seo_description,
    published_at,
    canvas_blocks
) VALUES (
    'impresion-digital-vs-flexografica-cual-elegir-para-etiquetas',
    'Impresión Digital vs Flexográfica: ¿Cuál Elegir para Etiquetas?',
    'Analizamos a fondo las diferencias clave, ventajas, costos y tabla comparativa entre la impresión digital y la flexografía tradicional para la toma de decisiones en plantas de etiquetado.',
    'https://images.unsplash.com/photo-1563770660941-20978e870e26?auto=format&fit=crop&w=1200&q=80',
    'Tecnología',
    ARRAY['Impresión Digital', 'Flexografía', 'Etiquetas Adhesivas', 'Costos de Producción', 'Tecnología de Impresión'],
    'Aleydis Reyes',
    'published',
    5,
    'Impresión Digital vs Flexográfica: ¿Cuál Elegir para Etiquetas? | Katun DPS',
    'Descubre las diferencias entre la impresión digital y la flexografía en costos, tiradas, tiempos de entrega y calidad para la industria de etiquetas.',
    NOW(),
    $$[
        {
            "id": "blk_intro_header",
            "type": "header",
            "content": {
                "title": "El impacto estratégico del etiquetado en la percepción de calidad",
                "subtitle": "Guía de decisión técnica entre metodologías digitales y tradicionales en la industria moderna de empaque",
                "badge": "ANÁLISIS COMPARATIVO",
                "align": "left"
            },
            "styles": { "padding": "medium" }
        },
        {
            "id": "blk_txt_intro",
            "type": "text",
            "content": {
                "html": "<p class=\"text-base sm:text-lg leading-relaxed text-slate-700\">Dentro de todo proceso productivo, existe una etapa que tiende a destacar debido a la íntima relación que tiene con la percepción del cliente: <strong>el etiquetado</strong>. Esta fase no sólo es crucial para el atractivo visual del producto, sino también dentro del marco de calidad.</p><p class=\"mt-4 text-base sm:text-lg leading-relaxed text-slate-700\">El etiquetado de un producto, de acuerdo a la industria a la que pertenece, debe cumplir con una serie de normativas que permitan garantizar su carácter; estas regulaciones aseguran (dentro de otros aspectos) que el producto no se vea afectado por ciertas condiciones físicas o ambientales, por ejemplo: altas o bajas temperaturas, exposición a líquidos o entornos desafiantes.</p><p class=\"mt-4 text-base sm:text-lg leading-relaxed text-slate-700\">Actualmente, el etiquetado no es sólo un requisito funcional, sino una <strong>herramienta estratégica que permite diferenciarse en mercados cada vez más competitivos</strong>. No obstante, en comparación con años anteriores, elegir la metodología idónea para crear etiquetas ya no es una decisión sencilla. En el pasado, las alternativas eran escasas y las soluciones evidentes, pero en un mundo que atraviesa cambios constantes y en donde la tecnología permite innovaciones aceleradas, la lista de opciones es cada vez más amplia, haciendo que elecciones entre técnicas de impresión sean cada vez más complejas.</p><p class=\"mt-4 text-base sm:text-lg leading-relaxed text-slate-700\">En este artículo exploraremos de forma general dos metodologías de impresión para etiquetas: <strong>impresión digital e impresión flexográfica</strong>. Principalmente abordaremos algunas características representativas de cada una, así como aspectos comparativos que considerar al momento de tomar una decisión.</p>"
            },
            "styles": { "padding": "small" }
        },
        {
            "id": "blk_def_digital",
            "type": "image_text",
            "content": {
                "title": "¿Qué es la Impresión Digital?",
                "description": "Es un método de impresión que permite emplear archivos digitales (como PDF o aquellos cuyo formato correspondan a archivos de diseño) para transferir imágenes o textos directamente al sustrato empleado.",
                "image": "https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80",
                "imageAlt": "Impresión digital directa sobre sustratos",
                "imagePosition": "right",
                "bullets": [
                    "No requiere placas ni clisés para trabajar",
                    "Elude por completo las configuraciones mecánicas complejas",
                    "Permite tiradas bajo demanda sin mínimos de producción",
                    "Personalización y datos variables (VDP) en cada etiqueta"
                ]
            },
            "styles": { "bgColor": "#f8fafc", "padding": "medium" }
        },
        {
            "id": "blk_def_flexo",
            "type": "image_text",
            "content": {
                "title": "¿Qué es la Impresión Flexográfica?",
                "description": "La flexografía se entiende como una metodología de impresión rotativa y tradicional que, a diferencia de la impresión digital, emplea placas o moldes flexibles (normalmente hechos de fotopolímero o caucho) que contienen la imagen requerida construida mediante relieve.",
                "image": "https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?auto=format&fit=crop&w=800&q=80",
                "imageAlt": "Línea de producción flexográfica",
                "imagePosition": "left",
                "bullets": [
                    "Mediante un rodillo anilox se transfiere tinta líquida al relieve de la placa",
                    "La placa con tinta gira y presiona contra el material creando el diseño",
                    "Si el diseño tiene varios colores, se usan varias placas (una por color) repitiendo el proceso",
                    "Altamente eficiente para volúmenes masivos donde el costo de placa se diluye"
                ]
            },
            "styles": { "bgColor": "#ffffff", "padding": "medium" }
        },
        {
            "id": "blk_table_comparison",
            "type": "text",
            "content": {
                "html": "<div class=\"space-y-4 my-6\"><h3 class=\"text-xl sm:text-2xl font-bold text-slate-900 flex items-center gap-2\"><span class=\"material-symbols-outlined text-[#00aeef]\">compare_arrows</span>Comparación entre Metodologías de Impresión</h3><div class=\"overflow-x-auto border border-slate-200 shadow-xs\"><table class=\"w-full text-left text-xs sm:text-sm\"><thead class=\"bg-slate-900 text-white uppercase text-[11px]\"><tr><th class=\"p-3.5 border-b border-slate-800\">Aspecto</th><th class=\"p-3.5 border-b border-slate-800 bg-[#00aeef]/20 text-[#00aeef]\">Impresión Digital</th><th class=\"p-3.5 border-b border-slate-800\">Flexografía</th></tr></thead><tbody class=\"divide-y divide-slate-200 text-slate-700 bg-white\"><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Volumen</td><td class=\"p-3 bg-[#00aeef]/5 font-medium text-[#0077b6]\">Ideal para tiradas cortas y medianas.</td><td class=\"p-3\">Ideal para tiradas largas y masivas.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Costos Iniciales</td><td class=\"p-3 bg-[#00aeef]/5\"><strong>Bajos</strong>. No requieren de placas ni configuración compleja.</td><td class=\"p-3\"><strong>Altos</strong>. Existe la necesidad de crear placas y configurar los equipos.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Flexibilidad</td><td class=\"p-3 bg-[#00aeef]/5\"><strong>Alta</strong>. Cambios de diseño rápidos y sin costos extra.</td><td class=\"p-3\"><strong>Baja</strong>. Los cambios requieren nuevas placas.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Calidad de impresión</td><td class=\"p-3 bg-[#00aeef]/5\"><strong>Excelente</strong>. Alta resolución y precisión de color. Ideal para degradados.</td><td class=\"p-3\"><strong>Buena</strong>. Menos detalle que la digital en tramas finas.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Velocidad</td><td class=\"p-3 bg-[#00aeef]/5\">Buena en tirada corta.</td><td class=\"p-3\">Muy rápida en grandes volúmenes continuos.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Personalización</td><td class=\"p-3 bg-[#00aeef]/5\"><strong>Perfecta</strong> para personalización y variantes de diseño.</td><td class=\"p-3\">Complicada y puede incurrir en costos adicionales.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Sustratos</td><td class=\"p-3 bg-[#00aeef]/5\">Amplia y en avance constante (BOPP, Couché, texturizados).</td><td class=\"p-3\">Amplia compatibilidad tradicional.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Tiempo de configuración</td><td class=\"p-3 bg-[#00aeef]/5 text-emerald-600 font-bold\">Rápido (minutos)</td><td class=\"p-3 text-amber-600 font-bold\">Lento (horas de ajuste de registro)</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Tintas</td><td class=\"p-3 bg-[#00aeef]/5\">Tintas acuosas/pigmentadas de secado rápido.</td><td class=\"p-3\">Tintas líquidas solventes o UV.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Sustentabilidad</td><td class=\"p-3 bg-[#00aeef]/5\"><strong>Menor desperdicio</strong> de materiales en pruebas. Tintas ecológicas.</td><td class=\"p-3\">Mayor merma durante la puesta a punto y lavado de rodillos.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Tiempos de entrega</td><td class=\"p-3 bg-[#00aeef]/5\"><strong>Rápidas</strong>. Ideales para trabajos urgentes o Just-in-Time.</td><td class=\"p-3\">Esperas más largas a causa de la elaboración de placas.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Complejidad del diseño</td><td class=\"p-3 bg-[#00aeef]/5\">Maneja diseños complejos y microtextos con facilidad.</td><td class=\"p-3\">Limitada en degradados suaves o micro-detalles.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Mantenimiento</td><td class=\"p-3 bg-[#00aeef]/5\">Mantenimiento simplificado y modular.</td><td class=\"p-3\">Mantenimiento mecánico frecuente y costoso.</td></tr><tr class=\"hover:bg-slate-50\"><td class=\"p-3 font-bold text-slate-900\">Espacio requerido</td><td class=\"p-3 bg-[#00aeef]/5\">Equipos más compactos (Huella reducida).</td><td class=\"p-3\">Trenes de máquinas grandes y pesadas.</td></tr></tbody></table></div></div>"
            },
            "styles": { "padding": "none" }
        },
        {
            "id": "blk_callout_conclusion",
            "type": "callout",
            "content": {
                "title": "Conclusión Estratégica",
                "text": "Cada metodología de impresión ya sea digital o flexográfica, tiene sus propias ventajas y desventajas. Es importante el poder visualizarlas como técnicas complementarias y no considerarlas rivales. La elección entre una y otra dependerá de las necesidades específicas de cada industria o inclusive de cada proyecto.",
                "icon": "workspace_premium",
                "variant": "primary"
            },
            "styles": { "bgColor": "#f0fdf4", "borderColor": "#16a34a" }
        },
        {
            "id": "blk_quote_hybrid",
            "type": "quote",
            "content": {
                "quote": "Integrar ambas estrategias podría ser el combo ideal para maximizar la eficiencia y adaptarse a un mercado en constante evolución.",
                "author": "Aleydis Reyes",
                "role": "Katun Digital Process Systems"
            },
            "styles": { "accentColor": "#00aeef" }
        },
        {
            "id": "blk_machine_dps",
            "type": "machine_card",
            "content": {
                "title": "Solución Digital Katun DPS: ArrowJet Aqua 330R",
                "description": "Línea de impresión digital de etiquetas con cabezales Memjet® DuraFlex a 1600 DPI continuos. Sin placas ni tiempos muertos.",
                "badge": "TECNOLOGÍA RECOMENDADA",
                "speed": "Hasta 45 m/min",
                "resolution": "1600 x 1600 DPI",
                "width": "330 mm",
                "ctaUrl": "/solucion/arrowjet-aqua-330r",
                "ctaText": "Ver Ficha Técnica"
            },
            "styles": { "bgColor": "#0f172a", "textColor": "#ffffff" }
        },
        {
            "id": "blk_sources",
            "type": "text",
            "content": {
                "html": "<div class=\"p-5 bg-slate-100 border border-slate-200 text-xs text-slate-600 space-y-2\"><h4 class=\"font-bold text-slate-900 uppercase text-[11px]\">Fuentes Consultadas</h4><ul class=\"list-disc pl-5 space-y-1\"><li><a href=\"https://www.esagraf.com/caracteristicas-impresion-flexografica/\" target=\"_blank\" rel=\"noopener\" class=\"text-[#00aeef] hover:underline\">«Características de la Impresión Flexográfica.» ESAGRAF.</a></li><li><a href=\"https://www.proprintweb.com/blog/la-impresion-flexografica\" target=\"_blank\" rel=\"noopener\" class=\"text-[#00aeef] hover:underline\">«La Impresión Flexográfica: Todo lo que Necesitas Saber.» ProPrintWeb.</a></li><li><a href=\"https://mammothpackaging.com/flexo-vs-digital-whats-the-difference/\" target=\"_blank\" rel=\"noopener\" class=\"text-[#00aeef] hover:underline\">«Flexo vs. Digital: ¿Cuál es la Diferencia?» Mammoth Packaging.</a></li><li><a href=\"https://www.ketegroup.com/es/impresion-digital-vs-flexografica/\" target=\"_blank\" rel=\"noopener\" class=\"text-[#00aeef] hover:underline\">«Impresión Digital vs. Flexográfica: ¿Cuál Elegir?» KETE Group.</a></li></ul></div>"
            },
            "styles": { "padding": "none" }
        },
        {
            "id": "blk_cta_showroom",
            "type": "cta",
            "content": {
                "title": "¿Deseas evaluar el costo por etiqueta en tu producción actual?",
                "description": "Solicita una corrida de prueba con tus propios diseños y comprueba la rentabilidad de la tecnología digital frente a la flexografía.",
                "buttonText": "Solicitar Muestra / Prueba en Showroom",
                "buttonUrl": "/contacto",
                "secondaryText": "Calcular Ahorro en Calculadora ROI",
                "secondaryUrl": "/#calculator"
            },
            "styles": { "bgColor": "linear-gradient(135deg, #00aeef 0%, #0077b6 100%)", "textColor": "#ffffff" }
        }
    ]$$::jsonb
)
ON CONFLICT (slug) DO NOTHING;
