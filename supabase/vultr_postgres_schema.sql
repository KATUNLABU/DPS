-- ====================================================================
-- KATUN DPS - ESQUEMA DE BASE DE DATOS PARA POSTGRESQL (VULTR VPS)
-- ====================================================================
-- Este archivo crea las tablas y siembra los 14 equipos del catálogo oficial.
-- Puedes pegarlo directamente en Adminer (http://TU_IP:8080) o ejecutarlo por terminal psql.

CREATE TABLE IF NOT EXISTS machines (
    id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    subtitle TEXT NOT NULL,
    category VARCHAR(50) NOT NULL CHECK (category IN ('impresoras', 'cortadoras', 'especiales')),
    technology VARCHAR(150),
    speed VARCHAR(100),
    resolution VARCHAR(100),
    max_width VARCHAR(100),
    description TEXT,
    badge VARCHAR(50),
    image TEXT,
    pdf_url TEXT,
    web_url TEXT,
    video_url TEXT,
    features JSONB DEFAULT '[]'::jsonb,
    specs JSONB DEFAULT '[]'::jsonb,
    industries JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices para búsquedas rápidas
CREATE INDEX IF NOT EXISTS idx_machines_category ON machines(category);

-- ====================================================================
-- INSERCIÓN DE LOS 14 EQUIPOS DEL CATÁLOGO OFICIAL
-- ====================================================================

-- --------------------------------------------------------------------
-- SECCIÓN 1: EQUIPOS INKJET
-- --------------------------------------------------------------------

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'vipcolor-vp610-vp660',
    'VIP Color 660',
    'Impresora de etiquetas con inyección de tinta directa, acabado brillantes y resistentes al agua',
    'impresoras',
    'Memjet Versapass®',
    'Hasta 18 m/min (305 mm/s)',
    '1600 x 1600 dpi',
    '20 cm (8")',
    'Impresora de etiquetas con inyección de tinta directa, acabado brillantes y resistentes al agua. Cabezal con 70,000 boquillas de micro-inyección para tirajes cortos y medianos bajo demanda.',
    'MÁS POPULAR',
    '/imagenes/02-katun-dps-impresora-vp-610-660-web_-pdf-791x1024.jpg',
    '/maquinas/02-katun-dps-impresora-vp-610-660-web_.pdf',
    'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/impresora-vip-color-uvp-660/',
    'https://www.youtube.com/embed/QFKxWpR_XJQ',
    '["Cabezal con 70,000 boquillas de micro-inyección", "Imprime hasta 2,400 etiquetas (4x6\") en solo 10 minutos", "Cartuchos de tinta individuales CMYK de 250ml", "Diseño compacto para laboratorio o línea de etiquetado", "Cero tiempos de preparación vs Flexografía"]'::jsonb,
    '[{"label": "TECNOLOGÍA", "value": "Memjet Versapass Single Pass"}, {"label": "VELOCIDAD ALTA RES", "value": "9 m/min a 1600x1600 dpi"}, {"label": "ANCHO IMPRESIÓN", "value": "20 cm (8\")"}]'::jsonb,
    '["Alimentos Refrigerados", "Salud y Nutrición", "Cuidado Personal", "Cosmética"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'aquajet-330-hybrid-pro-m',
    'ArrowJet Aqua 330R - Hybrid PRO M',
    'Para etiquetas de alta resolución, envases flexibles con priming y barnizado',
    'impresoras',
    'Memjet DuraFlex® Híbrida',
    'Hasta 21 m/min',
    '1600 x 1600 dpi',
    '32.4 cm (12.75")',
    'Para etiquetas de alta resolución, envases flexibles con priming y barnizado. El sistema todo-en-uno definitivo que imprime digitalmente en alta resolución, lamina en frío, troquela y retira la matriz de desperdicio en una sola pasada.',
    'HÍBRIDA PRO',
    '/imagenes/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_-pdf-791x1024.jpg',
    '/maquinas/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_.pdf',
    'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/arrowjet-aqua-330r-hybrid-pro-m/',
    'https://www.youtube.com/embed/D_fF7Vav0O4',
    '["Proceso completo desde bobina en blanco a etiqueta terminada", "Módulo de laminado en frío sincronizado", "Sistema de corte de contorno de alta precisión integrado", "Rebobinador de matriz de desperdicio incorporado"]'::jsonb,
    '[{"label": "IMPRESIÓN", "value": "Digital CMYK Memjet DuraFlex"}, {"label": "LAMINADO", "value": "Laminador en frío automático integrado"}]'::jsonb,
    '["Vinos y Licores", "Farmacéutica", "Químicos GHS", "Etiquetas Premium"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'katun-lt330',
    'LT330',
    'Impresión CMKY + Blanco',
    'impresoras',
    'Digital LED HD',
    '9.14 m/min',
    '1200 x 1200 dpi',
    '32 cm (12.6")',
    'Impresión CMYK + Blanco en bobina continua. Solución de impresión digital de etiquetas versátil y económica, capaz de imprimir sobre una amplísima variedad de sustratos sin necesidad de tratamiento previo.',
    'CMYK + BLANCO',
    '/imagenes/any-press_katun-dps-01.webp',
    '/maquinas/03-katun-dps-impresora-lt330-web-.pdf',
    'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/impresora-de-etiquetas-lt330-cmyk-blanco/',
    'https://www.youtube.com/embed/xmQ32C1a-yk',
    '["Tecnología de fusión seca LED de alta definición", "Excelente adhesión en materiales sintéticos y estucados", "Fácil operación sin necesidad de técnico calificado", "Registro perfecto en etiquetas multicolor con base blanca"]'::jsonb,
    '[{"label": "RESOLUCIÓN", "value": "1200 x 1200 dpi"}, {"label": "ANCHO DE BANDA", "value": "330 mm"}]'::jsonb,
    '["Etiquetas Industriales", "Señalamiento", "Bebidas y Vinos", "Etiquetas Pyme"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'katun-klt3',
    'KLT3',
    'Impresora de etiquetas CMYK rollo a rollo',
    'impresoras',
    'Inkjet Piezoeléctrico UV / Agua',
    'Hasta 30 m/min',
    '1200 x 1200 dpi',
    '33 cm (13")',
    'Impresora de etiquetas CMYK rollo a rollo. Prensa digital industrial robusta diseñada para operar 24/7 en entornos exigentes de conversión de etiquetas autoadhesivas.',
    'INDUSTRIA 24/7',
    '/imagenes/machine-klt3-industrial.png',
    '/maquinas/05-katun-dps-impresora-klt3_web.pdf',
    'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/klt3-impresora-de-etiquetas/',
    'https://www.youtube.com/embed/NMrxJahHZ-A',
    '["Cabezales piezoeléctricos de gota variable", "Curado UV LED de baja temperatura", "Excelente opacidad en blanco y colores vibrantes", "Construcción en acero mecanizado de grado industrial"]'::jsonb,
    '[{"label": "CABEZALES", "value": "Piezoeléctricos industriales"}, {"label": "ANCHO BANDA", "value": "330 mm"}]'::jsonb,
    '["Etiquetas Químicas", "Cosmética", "Decoración", "Vinos y Licores"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'arrowjet-aqua-330r',
    'ArrowJet Aqua 330R',
    'Impresora digital de inyección de tinta pigmentada de alta velocidad para etiquetas y empaques flexibles de alta resolución',
    'impresoras',
    'Memjet DuraFlex®',
    'Hasta 21 m/min (69 ft/min)',
    '1600 x 1600 dpi',
    '32.38 cm (12.75")',
    'Impresora digital de inyección de tinta pigmentada de alta velocidad para etiquetas y empaques flexibles de alta resolución en bobina. Diseñada para tirajes cortos y medianos con secado NIR instantáneo.',
    'MÁXIMA VELOCIDAD',
    '/imagenes/arrow-jet-aqua-330R-01.webp',
    '/maquinas/01-katun-dps-impresora-aqua-330r-web-2_.pdf',
    'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/arrowjet-aqua-330r/',
    'https://www.youtube.com/embed/6CFHlWSeYQU',
    '["Cabezal Memjet DuraFlex de larga vida útil", "Secado rápido por Infrarrojo Cercano (NIR)", "Tintas pigmentadas base agua resistentes al agua y luz", "Apta para etiquetas de alimentos, bebidas y productos químicos", "Depósitos de tinta de 2L o 10L para producción continua"]'::jsonb,
    '[{"label": "TIPO IMPRESIÓN", "value": "CMYK en un solo cabezal"}, {"label": "RESOLUCIÓN", "value": "1600x1600 dpi ó 1600x954 dpi"}, {"label": "ANCHO ROLLO MÁX", "value": "38.1 cm (15\")"}, {"label": "ANCHO IMPRESIÓN", "value": "32.38 cm (12.75\")"}]'::jsonb,
    '["Alimentos y Bebidas", "Químicos e Industriales", "Farmacéutica", "Limpieza del Hogar"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

-- --------------------------------------------------------------------
-- SECCIÓN 2: CORTADORAS Y FINALIZADORAS
-- --------------------------------------------------------------------

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'kf30x',
    'Cortadora KF30X',
    'Cortadora de Etiquetas Rollo a Rollo',
    'cortadoras',
    'Cuchilla Tangencial Digital (1 Cuchilla)',
    'Cerca de 1 m/min',
    '±0.05 mm',
    '30 cm (11.8")',
    'Cortadora de Etiquetas Rollo a Rollo. Plotter compacto de corte digital equipado con 1 cuchilla tangencial de alta precisión, alineación por sensor óptico y rebobinado de matriz para etiquetado.',
    '1 CUCHILLA TANGENCIAL',
    '/imagenes/cortadora-kf30x-brochure-web-pdf-791x1024.jpg',
    '/maquinas/cortadora-kf30x-brochure-web.pdf',
    'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/cortadora-etiquetas-kf30x/',
    NULL,
    '["Sistema de 1 cuchilla tangencial digital de gran precisión", "Velocidad de trabajo cercana a 1 m/min para máxima definición en bordes", "Laminador en frío con control de tensión de freno", "Estructura pesada antivibraciones"]'::jsonb,
    '[{"label": "ANCHO TRABAJO", "value": "300 mm"}, {"label": "CABEZALES", "value": "1 cuchilla tangencial digital"}, {"label": "VELOCIDAD REAL", "value": "Cerca de 1 m/min"}]'::jsonb,
    '["Etiquetas Adhesivas", "Rotulación", "Pequeñas Series de Etiquetas"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'arrow-ezcut-vr-240x',
    'VR 240 X',
    'Cortadora de Etiquetas de Mesa Rollo a Rollo',
    'cortadoras',
    'Plotter de Cuchilla Drag Knife',
    '6 m/min',
    '±0.1 mm',
    '24 cm (9.4")',
    'Cortadora de Etiquetas de Mesa Rollo a Rollo. Solución de acabado ligera y económica para pequeñas imprentas y talleres que buscan automatizar el corte de etiquetas.',
    'COMPACTA DE MESA',
    '/imagenes/arrow-ezcut-vr-240xbrochure-web_compressed-pdf-791x1024.jpg',
    '/maquinas/arrow-ezcut-vr-240xbrochure-web_compressed.pdf',
    'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/vr-240-x-cortadora-rollo-a-rollo/',
    NULL,
    '["Diseño compacto de escritorio", "Laminación en frío y rebobinado integrados", "Fácil importación de archivos de corte DXF/PLT", "Operación silenciosa y eficiente"]'::jsonb,
    '[{"label": "ANCHO ROLLO", "value": "240 mm"}, {"label": "VELOCIDAD CORTE", "value": "Hasta 6 m/min"}]'::jsonb,
    '["Pymes", "Emprendimientos", "Laboratorios de Pruebas"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'arrow-ezcut-330rx',
    'Arrow EzCut 330 RX',
    'Troqueladora digital de etiquetas de rollo a rollo multinavaja',
    'cortadoras',
    'Cuchillas Neumáticas Digitales',
    'Hasta 18 m/min',
    'Precisión 0.05 mm',
    '33 cm (13")',
    'Troqueladora digital de etiquetas de rollo a rollo multinavaja. Estación de acabado digital que integra laminación, corte de contorno continuo con cuchillas neumáticas, refilado de bordes y doble rebobinado.',
    'MULTI-NAVAJA',
    '/imagenes/arrow-ezcut-330-rx-nuevo-2025-01.webp',
    '/maquinas/arrow-ezcut-330rx-brochure-web_compressed.pdf',
    'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/arrow-ezcut-330-rx/',
    NULL,
    '["Corte continuo por archivo digital sin troqueles mecánicos", "Cabezales de corte con ajuste neumático de presión", "Laminado en frío incorporado", "Extracción automática de sobrante de etiqueta"]'::jsonb,
    '[{"label": "ANCHO BANDA", "value": "330 mm"}, {"label": "SISTEMA CORTE", "value": "Cuchillas de corte continuo"}]'::jsonb,
    '["Etiquetas bajo demanda", "Microcervecerías", "Marcas Propias"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'arrow-ezcut-350r',
    'VR 350',
    'Cortadora de etiquetas con cuchillas todo en uno, rollo a rollo',
    'cortadoras',
    'Láser CO2 Galvanométrico',
    'Hasta 50 m/min',
    'Submicrónica (Haz Láser)',
    '35 cm (13.7")',
    'Cortadora de etiquetas con cuchillas todo en uno, rollo a rollo. Sistema de troquelado digital avanzado que elimina totalmente el uso de troqueles físicos, permitiendo cambios de diseño instantáneos.',
    'TODO EN UNO',
    '/imagenes/arrow-ezcut-350R-brochure-web-_compressed-pdf-791x1024.jpg',
    '/maquinas/arrow-ezcut-350R-brochure-web-_compressed.pdf',
    'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/vr-230-cortadora-rollo-a-rollo-dps/',
    NULL,
    '["Fuente láser CO2 galvanométrica de respuesta ultra-rápida", "Corte de formas complejas, microperforaciones y semicorte", "Cambio automático de trabajo por lectura QR", "Sin desgaste mecánico de componentes"]'::jsonb,
    '[{"label": "TECNOLOGÍA LÁSER", "value": "Láser CO2 de alta frecuencia"}, {"label": "POTENCIA LÁSER", "value": "100W / 150W CO2"}, {"label": "ANCHO DE TRABAJO", "value": "350 mm"}]'::jsonb,
    '["Farmacéutica", "Etiquetas de Seguridad", "Electrónica", "Cosmética High-End"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'aries-35pl',
    'Aries',
    'Finalizadora de etiquetas semirotativa con capacidad de alta demanda',
    'cortadoras',
    'Troquelado Semi-Rotativo Servo',
    'Hasta 60 m/min',
    'Tolerancia ±0.1 mm',
    '35 cm (13.7")',
    'Finalizadora de etiquetas semirotativa con capacidad de alta demanda. Manejo avanzado de bobina con troquelado semi-rotativo servomotorizado para acabados impecables en etiquetas.',
    'SEMI-ROTATIVA',
    '/imagenes/aries-35plbrochure-web_compressed-pdf-791x1024.jpg',
    '/maquinas/aries-35plbrochure-web_compressed.pdf',
    'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/aries-finalizadoras-de-etiquetas-semirotativas/',
    NULL,
    '["Velocidad de hasta 60 m/min en modo semi-rotativo", "Alineación óptica por lectura de marca de registro", "Unidad de laminado y despalillado de matriz", "Cuchillas longitudinales de corte de tiras (slitting)"]'::jsonb,
    '[{"label": "ANCHO DE SUSTRATO", "value": "350 mm"}, {"label": "VELOCIDAD MÁXIMA", "value": "60 m/min"}]'::jsonb,
    '["Convertidores de Etiquetas", "Imprentas Comerciales", "Etiquetas Industriales"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'taurus-pl-series',
    'Taurus',
    'Finalizadora de etiquetas con corte láser, laminado y módulo de barniz UV',
    'cortadoras',
    'Multi-Cuchilla Digital Servo',
    'Hasta 30 m/min',
    '±0.05 mm',
    '35 cm (13.7")',
    'Finalizadora de etiquetas con corte láser, laminado y módulo de barniz UV. Serie versátil de finalizado de etiquetas disponible en anchos de 250mm y 350mm con sujeción por vacío.',
    'VACUUM PLATEN',
    '/imagenes/dpr-taurus-35-pl-katun-dps-plus.webp',
    '/maquinas/taurus-25-pl-35pl-35pl-plus-brochure-web_compressed.pdf',
    'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/taurus-cortadoras-laser-para-etiquetas-con-laminado/',
    NULL,
    '["Platen de succión por vacío multi-zona para sujeción perfecta del sustrato", "Cabezales de corte trabajando en paralelo", "Ajuste digital de profundidad y presión por cabezal"]'::jsonb,
    '[{"label": "MODELOS", "value": "Taurus 25PL (250mm) / 35PL (350mm) / 35PL Plus"}]'::jsonb,
    '["Producción Comercial", "Etiquetas de Alimentos", "Químicos"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'gemini-40',
    'Gemini 40',
    'Corte y acabado de etiquetas y empaques por pliego',
    'cortadoras',
    'Corte Digital por Hoja/Pliego',
    'Hasta 12 m/min',
    'Cámara CCD Óptica',
    '35 cm x 50 cm',
    'Corte y acabado de etiquetas y empaques por pliego. Equipo versátil para cortar contornos de etiquetas adhesivas en pliegos y hojas digitales de papel y sintéticos.',
    'CORTE EN HOJA',
    '/imagenes/brochue-cortadora-de-etiquetas-gemini-40-pdf-791x1024.jpg',
    '/maquinas/brochue-cortadora-de-etiquetas-gemini-40-.pdf',
    'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/dpr-gemini-40-60-corte-yacabado-de-etiquetas-por-pliego/',
    NULL,
    '["Alimentación automática de pliegos de etiquetas", "Cámara CCD para detección automática de marcas de registro", "Corte, semicorte y hendido en un solo paso", "Software intuitivo Gemini Cut Manager"]'::jsonb,
    '[{"label": "FORMATO MÁX", "value": "350 mm x 500 mm"}, {"label": "ALIMENTADOR", "value": "Capacidad para 100 pliegos"}]'::jsonb,
    '["Imprentas Digitales Sheetfed", "Diseño y Prototipado", "Etiquetas en Pliego"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'lc-350-pm',
    'LC 350 PM',
    'Corte de etiquetas y empaques por pliego con 2 navajas de corte y doblez',
    'cortadoras',
    'Láser CO2 Galvanométrico Industrial',
    'Hasta 80 m/min',
    'Submicrónica (Óptica Haz Láser)',
    '35 cm (13.7")',
    'Corte de etiquetas y empaques por pliego con 2 navajas de corte y doblez. Sistema insignia de troquelado óptico por láser de Katun DPS diseñado para líneas de conversión industrial de alto rendimiento.',
    'FLAGSHIP LÁSER',
    '/imagenes/machine-lc350pm-laser.png',
    '/maquinas/cortadora-de-etiquetas-lc-350-pm-katun-dps_nuevo-web.pdf',
    'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/lc-350-pm-cortadora-de-etiquetas-por-pliego/',
    NULL,
    '["Velocidad extrema de troquelado láser de hasta 80 m/min", "Corte por haz óptico de luz CO2", "Lectura QR al vuelo para cambio de diseño en microsegundos", "Módulo de barnizado UV e inspección de calidad opcional"]'::jsonb,
    '[{"label": "SISTEMA DE CORTE", "value": "Corte Láser Óptico CO2 (Sin Cuchillas)"}, {"label": "TECNOLOGÍA LÁSER", "value": "CO2 RF sellado galvanométrico"}, {"label": "VELOCIDAD MÁXIMA", "value": "80 m/min"}]'::jsonb,
    '["Converter Industrial de Etiquetas", "Farmacéutica de Alto Volumen", "Bebidas Globales"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

-- --------------------------------------------------------------------
-- SECCIÓN 3: CONTADOR DE ETIQUETAS AUTOMÁTICO ROLLO A ROLLO
-- --------------------------------------------------------------------

INSERT INTO machines (id, name, subtitle, category, technology, speed, resolution, max_width, description, badge, image, pdf_url, web_url, video_url, features, specs, industries)
VALUES 
(
    'contador-automatico',
    'Contador de Etiquetas Automático Rollo a Rollo',
    'Contador Rollo a Rollo',
    'especiales',
    'Sensor Ultrasónico + Fotoeléctrico',
    'Hasta 300 m/min',
    '100% Precisión',
    '35 cm (13.7")',
    'Contador Rollo a Rollo. Unidad indispensable para el control de calidad final. Cuenta con precisión absoluta etiquetas opacas, transparentes y metálicas a alta velocidad.',
    'CONTROL QA',
    '/imagenes/machine-contador-etiquetas.png',
    '/maquinas/contador-de-automatico-de-etiquetas-web_red.pdf',
    'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/contador-de-automatico-de-etiquetas/',
    NULL,
    '["Detección ultrasónica para etiquetas transparentes / clear-on-clear", "Conteo por número de etiquetas o por metros lineales", "Paro automático al alcanzar el conteo programado"]'::jsonb,
    '[{"label": "VELOCIDAD MÁXIMA", "value": "300 m/min"}, {"label": "SENSORES", "value": "Óptico fotoeléctrico + Ultrasónico de brecha"}]'::jsonb,
    '["Control de Calidad", "Inspección Final", "Farmacéutica GXP"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;
