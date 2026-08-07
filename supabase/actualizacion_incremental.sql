-- ====================================================================
-- KATUN DPS - SCRIPT DE ACTUALIZACIÓN INCREMENTAL PARA SUPABASE
-- Copia y pega este script completo en tu SQL Editor de Supabase
-- ====================================================================

-- 1. CREACIÓN DE LA TABLA UNIFICADA DE REGISTROS DE LA WEB
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

-- 2. HABILITAR RLS Y RE-CREAR POLÍTICAS DE SEGURIDAD SAFELY
ALTER TABLE public.dps_web_registros ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Permitir envío público de registros de la web" ON public.dps_web_registros;
DROP POLICY IF EXISTS "Lectura privada de registros para administradores" ON public.dps_web_registros;
DROP POLICY IF EXISTS "Actualización de registros solo para administradores" ON public.dps_web_registros;

CREATE POLICY "Permitir envío público de registros de la web" 
    ON public.dps_web_registros FOR INSERT WITH CHECK (true);

CREATE POLICY "Lectura privada de registros para administradores" 
    ON public.dps_web_registros FOR SELECT 
    USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

CREATE POLICY "Actualización de registros solo para administradores" 
    ON public.dps_web_registros FOR UPDATE 
    USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

-- 3. ÍNDICES DE BÚSQUEDA RÁPIDA
CREATE INDEX IF NOT EXISTS idx_dps_registros_email ON public.dps_web_registros(email);
CREATE INDEX IF NOT EXISTS idx_dps_registros_status ON public.dps_web_registros(status);
CREATE INDEX IF NOT EXISTS idx_dps_registros_created_at ON public.dps_web_registros(created_at DESC);

-- ====================================================================
-- 4. ACTUALIZACIÓN DE LOS 14 EQUIPOS CON RUTAS LOCALES (IMÁGENES Y PDFS)
-- ====================================================================
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
