-- ====================================================================
-- KATUN DPS - SCRIPT GLOBAL DE LIMPIEZA Y ORGANIZACIÓN DE TABLAS
-- Copia y ejecuta este script en el Editor SQL de Supabase (SQL Editor)
-- ====================================================================

-- --------------------------------------------------------------------
-- PASO 1: ELIMINAR TABLAS TEMPORALES / DUPLICADAS CREADAS EN ESTE PROYECTO
-- (Se respetan intactas las tablas de otros proyectos como 'registrations')
-- --------------------------------------------------------------------
DROP TABLE IF EXISTS public.contact_submissions CASCADE;
DROP TABLE IF EXISTS public.sample_requests CASCADE;
DROP TABLE IF EXISTS public.roi_simulations CASCADE;

-- --------------------------------------------------------------------
-- PASO 2: CREACIÓN DE LAS 5 TABLAS OFICIALES DE KATUN DPS
-- --------------------------------------------------------------------

-- TABLA 1: INDUSTRIAS / SECTORES
CREATE TABLE IF NOT EXISTS public.industries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    tag TEXT NOT NULL,
    icon TEXT NOT NULL,
    image TEXT NOT NULL,
    description TEXT NOT NULL,
    subsections JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- TABLA 2: PRODUCTOS / MÁQUINAS (LOS 14 EQUIPOS)
CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    subtitle TEXT NOT NULL,
    category TEXT NOT NULL CHECK (category IN ('impresoras', 'cortadoras', 'especiales')),
    technology TEXT NOT NULL,
    speed TEXT NOT NULL,
    resolution TEXT NOT NULL,
    max_width TEXT NOT NULL,
    description TEXT NOT NULL,
    features JSONB DEFAULT '[]'::jsonb,
    specs JSONB DEFAULT '[]'::jsonb,
    pdf_url TEXT DEFAULT '',
    badge TEXT DEFAULT '',
    image TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- TABLA 3: CATÁLOGOS PDF
CREATE TABLE IF NOT EXISTS public.catalogs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    pdf_url TEXT NOT NULL,
    category TEXT DEFAULT 'General',
    product_slug TEXT REFERENCES public.products(slug) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- TABLA 4: RELACIÓN PRODUCTO <-> INDUSTRIA
CREATE TABLE IF NOT EXISTS public.product_industries (
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    industry_id UUID REFERENCES public.industries(id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, industry_id)
);

-- TABLA 5: REGISTROS UNIFICADOS DE LA WEB (FORMULARIOS, COTIZACIONES, MUESTRAS Y ROI)
CREATE TABLE IF NOT EXISTS public.dps_web_registros (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    form_type TEXT NOT NULL DEFAULT 'contacto' 
        CHECK (form_type IN ('cotizacion', 'showroom_demo', 'muestras_gratis', 'calculadora_roi', 'contacto_general', 'whatsapp_directo')),
    source_page TEXT DEFAULT '/',
    full_name TEXT NOT NULL,
    company TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    equipment_interest TEXT DEFAULT 'Asesoría General',
    industry_sector TEXT DEFAULT 'General',
    message TEXT,
    substrate_type TEXT,
    shipping_address TEXT,
    roi_run_quantity INTEGER,
    roi_designs_count INTEGER,
    roi_prep_minutes INTEGER,
    roi_total_minutes INTEGER,
    status TEXT DEFAULT 'nuevo' 
        CHECK (status IN ('nuevo', 'contactado', 'en_cotizacion', 'demostracion_agendada', 'muestras_enviadas', 'cerrado_ganado', 'descartado')),
    internal_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------------
-- PASO 3: CONFIGURACIÓN DE POLÍTICAS DE SEGURIDAD (RLS)
-- --------------------------------------------------------------------
ALTER TABLE public.industries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.catalogs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_industries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dps_web_registros ENABLE ROW LEVEL SECURITY;

-- Limpieza preventiva de políticas anteriores
DROP POLICY IF EXISTS "Lectura pública de industrias" ON public.industries;
DROP POLICY IF EXISTS "Permitir inserción de industrias" ON public.industries;
DROP POLICY IF EXISTS "Permitir actualización de industrias" ON public.industries;

DROP POLICY IF EXISTS "Lectura pública de productos" ON public.products;
DROP POLICY IF EXISTS "Permitir inserción de productos" ON public.products;
DROP POLICY IF EXISTS "Permitir actualización de productos" ON public.products;

DROP POLICY IF EXISTS "Lectura pública de catálogos" ON public.catalogs;
DROP POLICY IF EXISTS "Lectura pública de relaciones producto_industria" ON public.product_industries;

DROP POLICY IF EXISTS "Permitir envío público de registros de la web" ON public.dps_web_registros;
DROP POLICY IF EXISTS "Lectura privada de registros para administradores" ON public.dps_web_registros;
DROP POLICY IF EXISTS "Actualización de registros solo para administradores" ON public.dps_web_registros;

-- Creación de políticas limpias
CREATE POLICY "Lectura pública de industrias" ON public.industries FOR SELECT USING (true);
CREATE POLICY "Permitir inserción de industrias" ON public.industries FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización de industrias" ON public.industries FOR UPDATE USING (true);

CREATE POLICY "Lectura pública de productos" ON public.products FOR SELECT USING (true);
CREATE POLICY "Permitir inserción de productos" ON public.products FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización de productos" ON public.products FOR UPDATE USING (true);

CREATE POLICY "Lectura pública de catálogos" ON public.catalogs FOR SELECT USING (true);
CREATE POLICY "Lectura pública de relaciones producto_industria" ON public.product_industries FOR SELECT USING (true);

CREATE POLICY "Permitir envío público de registros de la web" ON public.dps_web_registros FOR INSERT WITH CHECK (true);
CREATE POLICY "Lectura privada de registros para administradores" ON public.dps_web_registros FOR SELECT USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');
CREATE POLICY "Actualización de registros solo para administradores" ON public.dps_web_registros FOR UPDATE USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

-- Índices de búsqueda
CREATE INDEX IF NOT EXISTS idx_dps_registros_email ON public.dps_web_registros(email);
CREATE INDEX IF NOT EXISTS idx_dps_registros_status ON public.dps_web_registros(status);
CREATE INDEX IF NOT EXISTS idx_dps_registros_created_at ON public.dps_web_registros(created_at DESC);

-- --------------------------------------------------------------------
-- PASO 4: POBLACIÓN DE DATOS (7 INDUSTRIAS Y 14 EQUIPOS)
-- --------------------------------------------------------------------
INSERT INTO public.industries (slug, title, tag, icon, image, description, subsections)
VALUES
(
    'bebidas',
    'Industria de Bebidas',
    'VINO, CERVEZA & DESTILADOS',
    'wine_bar',
    'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?auto=format&fit=crop&w=800&q=80',
    'Ofrecemos una amplia variedad de tecnología de impresión de etiquetas que permite a nuestros clientes imprimir y cortar fácilmente sus propias etiquetas de vino o cerveza. ¿Buscas darle a tu etiqueta un poco más de pop? ¡Tenemos una amplia variedad de materiales especiales que ayudarán a que su marca se destaque en el estante! Imprima sus propias etiquetas de cerveza personalizadas y etiquetas de vino personalizadas cuando las necesite. Se acabaron las cantidades mínimas de pedido o las primas para las etiquetas de tiradas cortas. Imprima solo lo que necesita para no tener que mantener un inventario de etiquetas preimpresas.',
    '["Vino y Cerveza Artesanal", "Sin Mínimos de Pedido", "Sustratos Especiales & Texturizados", "Resistencia a Humedad y Hielo"]'::jsonb
),
(
    'química',
    'Industria Química',
    'ETIQUETADO GHS & BS5609',
    'science',
    'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=800&q=80',
    'En lo que respecta a las etiquetas químicas, la impresión digital es flexible. Esta flexibilidad le permite ajustar su etiqueta a medida que cambian las condiciones que rodean la industria. Ya sea que se trate de nuevas pautas sobre el manejo o de un nuevo color para encajar en el sistema armonizado, su empresa ahora tiene la capacidad de adaptarse e imprimir exactamente lo que busca su cliente. Esta poderosa máquina de impresión de inyección de tinta utiliza tintas pigmentadas acuosas que brindan no solo durabilidad, sino también una impresionante recompensa de color que contará con una longevidad durante toda su vida útil. Obtenga más información sobre ArrowJet Aqua 330R aquí hoy y comuníquese para obtener más información.',
    '["Etiquetas para Químicos", "Empaques Flexibles", "Cumplimiento GHS y OSHA", "Tintas Pigmentadas de Alta Resistencia"]'::jsonb
),
(
    'comestibles',
    'Industria de Comestibles',
    'EMPAQUES FLEXIBLES & MYLAR',
    'shopping_bag',
    'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?auto=format&fit=crop&w=800&q=80',
    '¡Ofrecemos una amplia gama de equipos para producir empaques flexibles para una variedad de industrias que incluyen empaques de alimentos, empaques farmacéuticos, bolsas de café, comestibles de cannabis y más! Lo ayudaremos a crear una solución llave en mano para las necesidades de empaque flexible de su empresa en función del volumen de bolsas de mylar que necesita producir y su presupuesto para el proyecto. Además de las impresoras y los materiales, lo ayudaremos a ubicar el equipo VFFS o HFFS adecuado para llenar y sellar su empaque. Ya sea una solución que ofrecemos lista para usar o una creación personalizada, tenemos la capacidad de ayudar a impulsar el crecimiento de su empresa a través de soluciones de empaque flexible personalizadas.',
    '["Empaques de Alimentos y Café", "Comestibles de Cannabis", "Bolsas Mylar Personalizadas", "Integración con Equipos VFFS / HFFS"]'::jsonb
),
(
    'productos-varios',
    'Industria de Productos Varios',
    'ON-DEMAND & CORTO TIRAJE',
    'inventory_2',
    'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=800&q=80',
    'Nuestros sistemas le permiten imprimir lo que necesita bajo demanda. Ya sea que necesite imprimir 1 etiqueta o 10,000 etiquetas, tenemos un sistema que funcionará para las necesidades de su negocio. ¡No es necesario esperar a que un proveedor de etiquetas le envíe etiquetas para sus productos cuando puede lograr el mismo nivel de producción de etiquetas internamente por mucho menos! Con la capacidad de personalizar fácilmente las etiquetas de su empresa para una producción corta, ¡nuestros sistemas de impresión de etiquetas permiten una mayor flexibilidad en cualquier proyecto!',
    '["Etiquetas para Embalaje", "Etiquetado Farmacéutica", "Producción Interna In-House", "Impresión de 1 a 10,000 Etiquetas"]'::jsonb
),
(
    'farmaceutica',
    'Industria Farmacéutica',
    'TRAZABILIDAD & LAMINADOS',
    'medication',
    'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=800&q=80',
    'Las nuevas tecnologías, como los envases flexibles, las tintas de alta calidad y los envases laminados, permiten a las empresas farmacéuticas adaptarse rápidamente según sea necesario. La impresión digital ha ofrecido a muchas industrias la oportunidad de imprimir solo la cantidad necesaria y, en última instancia, reducir sus costos de inventario. Esto ayuda a medida que las empresas avanzan y continúan implementando nuevos diseños independientemente de los cambios en las regulaciones o las preferencias de los clientes.',
    '["Envases Laminados", "Tintas de Alta Calidad", "Optimización de Inventario", "Flexibilidad Regulatoria"]'::jsonb
),
(
    'grafica',
    'Industria Gráfica',
    'SEÑALÉTICA & MATERIALES ESPECIALES',
    'palette',
    'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=800&q=80',
    'Desde sus inicios, Arrow Systems Inc. ha mantenido relaciones sólidas y duraderas con muchas de las marcas más confiables y respetadas de la industria de letreros y gráficos, como Gerber Technology. Esto ha permitido a nuestros clientes tener acceso a las tecnologías más avanzadas junto con nuestro principal sistema de distribución y atención al cliente. Utilizando la última tecnología de impresión disponible, nuestros sistemas le permiten diseñar e imprimir cualquier cosa que pueda imaginar en láminas de fibrocemento o baldosas de cerámica.',
    '["Señalética y Similares", "Etiquetas para las Industrias", "Sustratos Rígidos (Fibrocemento/Cerámica)", "Tecnología Gerber Technology"]'::jsonb
),
(
    'fabricacion',
    'Fabricación e Industria',
    'NORMATIVAS OSHA, UL, GHS, ANSI',
    'precision_manufacturing',
    'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80',
    'Arrow system Inc. cuenta con múltiples sistemas para la creación de etiquetas industriales y químicas. Ya sea que esté buscando crear etiquetas para equipos, fabricación de productos químicos o sistemas de etiquetado a nivel de producción, Arrow tiene las opciones de impresión y acabado adecuadas para satisfacer sus necesidades. Tenemos impresoras que crean etiquetas para las pautas más estrictas. Ya sea que se trate de la certificación OSHA, UL, GHS o ANSI, tenemos un sistema que cumplirá con las especificaciones necesarias.',
    '["Etiquetas para Equipos", "Certificaciones OSHA, UL, GHS, ANSI", "Producción Continuada", "Prensas Digitales y Acabadores"]'::jsonb
)
ON CONFLICT (slug) DO UPDATE 
SET title = EXCLUDED.title,
    tag = EXCLUDED.tag,
    icon = EXCLUDED.icon,
    image = EXCLUDED.image,
    description = EXCLUDED.description,
    subsections = EXCLUDED.subsections;

INSERT INTO public.products (slug, name, subtitle, category, technology, speed, resolution, max_width, description, features, specs, pdf_url, badge, image)
VALUES
(
    'arrowjet-aqua-330r',
    'ArrowJet Aqua 330R',
    'Impresora Digital de Etiquetas Rollo a Rollo de Alta Velocidad',
    'impresoras',
    'Memjet DuraFlex®',
    'Hasta 21 m/min (69 ft/min)',
    '1600 x 1600 dpi',
    '32.38 cm (12.75")',
    'Impresora industrial de alta producción con tintas pigmentadas en base agua. Diseñada para tirajes medianos y largos con secado NIR (Near InfraRed) instantáneo.',
    '["Cabezal Memjet DuraFlex de larga vida útil", "Secado rápido por Infrarrojo Cercano (NIR)", "Tintas pigmentadas base agua resistentes al agua y luz", "Apta para alimentos, bebidas y productos químicos"]'::jsonb,
    '[{"label": "TIPO IMPRESIÓN", "value": "CMYK en un solo cabezal"}, {"label": "RESOLUCIÓN", "value": "1600x1600 dpi"}]'::jsonb,
    '/maquinas/01-katun-dps-impresora-aqua-330r-web-2_.pdf',
    'MÁXIMA VELOCIDAD',
    '/imagenes/arrow-jet-aqua-330R-01.webp'
),
(
    'vipcolor-vp610-vp660',
    'VIPColor VP610 / VP660',
    'Impresoras Digitales de Escritorio Memjet Versapass',
    'impresoras',
    'Memjet Versapass®',
    'Hasta 18 m/min (305 mm/s)',
    '1600 x 1600 dpi',
    '20 cm (8")',
    'Impresión de etiquetas a color bajo demanda para tirajes medianos. La VP660 incluye fórmula de tinta acuosa mejorada resistente a la humedad y salpicaduras.',
    '["Cabezal con 70,000 boquillas de micro-inyección", "Imprime hasta 2,400 etiquetas (4x6\") en solo 10 minutos"]'::jsonb,
    '[{"label": "TECNOLOGÍA", "value": "Memjet Versapass Single Pass"}]'::jsonb,
    '/maquinas/02-katun-dps-impresora-vp-610-660-web_.pdf',
    'MÁS POPULAR',
    '/imagenes/02-katun-dps-impresora-vp-610-660-web_-pdf-791x1024.jpg'
),
(
    'katun-lt330',
    'Katun DPS LT330 / Any-Press',
    'Prensa Digital Compacta de Etiquetas LED High Definition',
    'impresoras',
    'Digital LED HD',
    '9.14 m/min',
    '1200 x 1200 dpi',
    '32 cm (12.6")',
    'Solución de impresión digital de etiquetas versátil y económica, capaz de imprimir sobre una amplísima variedad de sustratos sin necesidad de tratamiento previo.',
    '["Tecnología de fusión seca LED de alta definición", "Excelente adhesión en materiales sintéticos y estucados"]'::jsonb,
    '[{"label": "RESOLUCIÓN", "value": "1200 x 1200 dpi"}]'::jsonb,
    '/maquinas/03-katun-dps-impresora-lt330-web-.pdf',
    'VERSATILIDAD LED',
    '/imagenes/any-press_katun-dps-01.webp'
),
(
    'aquajet-330-hybrid-pro-m',
    'Aqua Jet 330 Hybrid Pro M',
    'Impresora Híbrida Digital + Acabado Integrado en Línea',
    'impresoras',
    'Memjet DuraFlex® Híbrida',
    'Hasta 21 m/min',
    '1600 x 1600 dpi',
    '32.4 cm (12.75")',
    'El sistema todo-en-uno definitivo: imprime digitalmente en alta resolución, lamina en frío, corta con cuchilla/láser y retira el desperdicio en una sola pasada.',
    '["Proceso completo desde bobina en blanco a etiqueta terminada", "Módulo de laminado en frío sincronizado"]'::jsonb,
    '[{"label": "IMPRESIÓN", "value": "Digital CMYK Memjet DuraFlex"}]'::jsonb,
    '/maquinas/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_.pdf',
    'HÍBRIDA PRO',
    '/imagenes/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_-pdf-791x1024.jpg'
),
(
    'katun-klt3',
    'Katun KLT3 Industrial',
    'Prensa Digital Inkjet para Etiquetas y Películas Flexibles',
    'impresoras',
    'Inkjet Piezoeléctrico UV / Agua',
    'Hasta 30 m/min',
    '1200 x 1200 dpi',
    '33 cm (13")',
    'Impresora industrial robusta diseñada para operar 24/7 en entornos exigentes de conversión de etiqueta y empaque flexible.',
    '["Cabezales piezoeléctricos de gota variable", "Curado UV LED de baja temperatura"]'::jsonb,
    '[{"label": "CABEZALES", "value": "Piezoeléctricos industriales"}]'::jsonb,
    '/maquinas/05-katun-dps-impresora-klt3_web.pdf',
    'INDUSTRIA 24/7',
    '/imagenes/hero-contacto-equipo-2.webp'
),
(
    'aries-35pl',
    'Aries 35PL',
    'Cortadora Digital de Etiquetas Semi-Rotativa de Alta Precisión',
    'cortadoras',
    'Troquelado Semi-Rotativo Servo',
    'Hasta 60 m/min',
    'Tolerancia ±0.1 mm',
    '35 cm (13.7")',
    'Manejo avanzado de bobina con troquelado semi-rotativo servomotorizado. Permite utilizar cilindros de troquel magnético universales para acabados impecables.',
    '["Velocidad de hasta 60 m/min en modo semi-rotativo", "Alineación óptica por lectura de marca de registro"]'::jsonb,
    '[{"label": "ANCHO DE SUSTRATO", "value": "350 mm"}]'::jsonb,
    '/maquinas/aries-35plbrochure-web_compressed.pdf',
    'SEMI-ROTATIVA',
    '/imagenes/aries-35plbrochure-web_compressed-pdf-791x1024.jpg'
),
(
    'arrow-ezcut-330rx',
    'Arrow EZCut 330RX',
    'Sistema Digital de Acabado y Corte con Múltiples Cuchillas',
    'cortadoras',
    'Cuchillas Neumáticas Digitales',
    'Hasta 18 m/min',
    'Precisión 0.05 mm',
    '33 cm (13")',
    'Estación de acabado digital compacta que integra laminación, corte de contorno continuo con múltiples cuchillas, refilado de bordes y doble rebobinado.',
    '["Corte continuo por archivo digital sin troqueles mecánicos", "Múltiples cabezales de corte simultáneos"]'::jsonb,
    '[{"label": "ANCHO BANDA", "value": "330 mm"}]'::jsonb,
    '/maquinas/arrow-ezcut-330rx-brochure-web_compressed.pdf',
    'MULTI-CUCHILLA',
    '/imagenes/arrow-ezcut-330-rx-nuevo-2025-01.webp'
),
(
    'arrow-ezcut-350r',
    'Arrow EZCut 350R Láser',
    'Sistema de Acabado y Troquelado Láser Industrial',
    'cortadoras',
    'Láser CO2 Galvanométrico',
    'Hasta 50 m/min',
    'Submicrónica',
    '35 cm (13.7")',
    'Corte digital por láser de alta potencia. Elimina por completo los costos y tiempos de espera de placas de troquel físico, permitiendo cambios de forma instantáneos.',
    '["Fuente láser CO2 galvanométrica de respuesta ultra-rápida", "Corte de formas complejas y microperforaciones"]'::jsonb,
    '[{"label": "POTENCIA LÁSER", "value": "100W / 150W CO2"}]'::jsonb,
    '/maquinas/arrow-ezcut-350R-brochure-web-_compressed.pdf',
    'CORTE LÁSER',
    '/imagenes/arrow-ezcut-350R-brochure-web-_compressed-pdf-791x1024.jpg'
),
(
    'arrow-ezcut-vr-240x',
    'Arrow EZCut VR 240X',
    'Cortadora Digital Compacta para Etiquetas en Bobina',
    'cortadoras',
    'Ploter de Cuchilla Drag Knife',
    '6 m/min',
    '±0.1 mm',
    '24 cm (9.4")',
    'Solución de acabado ligera y económica para pequeñas imprentas y talleres que buscan automatizar el corte de etiquetas impresas en VP610 o similares.',
    '["Diseño compacto de escritorio", "Laminación en frío y rebobinado integrados"]'::jsonb,
    '[{"label": "ANCHO ROLLO", "value": "240 mm"}]'::jsonb,
    '/maquinas/arrow-ezcut-vr-240xbrochure-web_compressed.pdf',
    'COMPACTA',
    '/imagenes/arrow-ezcut-vr-240xbrochure-web_compressed-pdf-791x1024.jpg'
),
(
    'gemini-40',
    'Cortadora Gemini 40',
    'Cortadora Digital de Etiquetas en Hojas y Bobinas Cortas',
    'cortadoras',
    'Corte Digital por Hoja/Rollo',
    'Hasta 12 m/min',
    'Cámara CCD Óptica',
    '35 cm x 50 cm',
    'Equipo versátil para cortar etiquetas tanto en pliegos/hojas como en rollos pequeños. Ideal para complementar prensas de hoja digital.',
    '["Alimentación automática de pliegos", "Cámara CCD para detección automática de marcas de registro"]'::jsonb,
    '[{"label": "FORMATO MÁX", "value": "350 mm x 500 mm"}]'::jsonb,
    '/maquinas/brochue-cortadora-de-etiquetas-gemini-40-.pdf',
    'HOJAS Y ROLLO',
    '/imagenes/brochue-cortadora-de-etiquetas-gemini-40-pdf-791x1024.jpg'
),
(
    'lc-350-pm',
    'Cortadora LC 350 PM Katun DPS',
    'Sistema de Corte Láser Industrial de Alta Productividad',
    'cortadoras',
    'Láser Galvanométrico Premium',
    'Hasta 80 m/min',
    'Submicrónica',
    '35 cm (13.7")',
    'El buque insignia en troquelado láser de Katun DPS. Diseñado para líneas de conversión industrial de alto rendimiento con código QR dinámico.',
    '["Velocidad extrema de hasta 80 m/min", "Lectura QR al vuelo para cambio de diseño en microsegundos"]'::jsonb,
    '[{"label": "TECNOLOGÍA LÁSER", "value": "CO2 RF sellado galvanométrico"}]'::jsonb,
    '/maquinas/cortadora-de-etiquetas-lc-350-pm-katun-dps_nuevo-web.pdf',
    'FLAGSHIP LÁSER',
    '/imagenes/hero-nosotros-expo-grafica.webp'
),
(
    'kf30x',
    'Cortadora KF30X',
    'Ploter Digital de Acabado de Etiquetas y Semicorte',
    'cortadoras',
    'Cuchilla Tangencial Digital',
    '12 m/min',
    '±0.05 mm',
    '30 cm (11.8")',
    'Ploter de corte digital robusto con sistema de alineación láser y rebobinado de desecho para producciones continuas de etiquetado.',
    '["Corte tangencial de gran precisión en esquinas complejas", "Laminador en frío con control de tensión de freno"]'::jsonb,
    '[{"label": "ANCHO TRABAJO", "value": "300 mm"}]'::jsonb,
    '/maquinas/cortadora-kf30x-brochure-web.pdf',
    'PRECISIÓN TANGENCIAL',
    '/imagenes/cortadora-kf30x-brochure-web-pdf-791x1024.jpg'
),
(
    'taurus-pl-series',
    'Taurus 25PL / 35PL / 35PL Plus',
    'Plotters de Corte Digital con Platen de Vacío Multi-Zona',
    'cortadoras',
    'Multi-Cuchilla Digital Servo',
    'Hasta 30 m/min',
    '±0.05 mm',
    '35 cm (13.7")',
    'Serie versátil de plotters de corte industrial disponibles en anchos de 250mm y 350mm con hasta 4 cabezales de corte independientes sincronizados.',
    '["Platen de succión por vacío multi-zona para sujeción perfecta del sustrato", "Hasta 4 cabezales de corte trabajando en paralelo"]'::jsonb,
    '[{"label": "MODELOS", "value": "Taurus 25PL (250mm) / 35PL (350mm) / 35PL Plus"}]'::jsonb,
    '/maquinas/taurus-25-pl-35pl-35pl-plus-brochure-web_compressed.pdf',
    'VACUUM PLATEN',
    '/imagenes/dpr-taurus-35-pl-katun-dps-plus.webp'
),
(
    'contador-automatico',
    'Contador Automático de Etiquetas Katun',
    'Equipo de Inspección, Conteo y Rebobinado de Precisión',
    'especiales',
    'Sensor Ultrasónico + Fotoeléctrico',
    'Hasta 300 m/min',
    '100% Precisión',
    '35 cm (13.7")',
    'Unidad indispensable para el control de calidad final. Cuenta con precisión absoluta etiquetas opacas, transparentes y metálicas a alta velocidad.',
    '["Detección ultrasónica para etiquetas transparentes / clear-on-clear", "Conteo por número de etiquetas o por metros lineales"]'::jsonb,
    '[{"label": "VELOCIDAD MÁXIMA", "value": "300 m/min"}]'::jsonb,
    '/maquinas/contador-de-automatico-de-etiquetas-web_red.pdf',
    'CONTROL QA',
    '/imagenes/KATUN-DPS-Catalogo-01-28-2025_web-pdf-791x1024.jpg'
)
ON CONFLICT (slug) DO UPDATE
SET name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    pdf_url = EXCLUDED.pdf_url,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image;
