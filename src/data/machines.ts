export interface MachineSpec {
  label: string;
  value: string;
}

export interface Machine {
  id: string;
  name: string;
  subtitle: string;
  category: 'impresoras' | 'cortadoras' | 'especiales';
  technology: string;
  speed: string;
  resolution: string;
  maxWidth: string;
  description: string;
  features: string[];
  specs: MachineSpec[];
  industries: string[];
  pdfUrl: string;
  badge?: string;
  image: string;
}

export const MACHINES: Machine[] = [
  {
    id: "arrowjet-aqua-330r",
    name: "ArrowJet Aqua 330R",
    subtitle: "Impresora Digital de Etiquetas Rollo a Rollo de Alta Velocidad",
    category: "impresoras",
    technology: "Memjet DuraFlex®",
    speed: "Hasta 21 m/min (69 ft/min)",
    resolution: "1600 x 1600 dpi",
    maxWidth: "32.38 cm (12.75\")",
    description: "Impresora industrial de alta producción con tintas pigmentadas en base agua. Diseñada para tirajes medianos y largos con secado NIR (Near InfraRed) instantáneo.",
    badge: "MÁXIMA VELOCIDAD",
    image: "/imagenes/arrow-jet-aqua-330R-01.webp",
    pdfUrl: "/maquinas/01-katun-dps-impresora-aqua-330r-web-2_.pdf",
    features: [
      "Cabezal Memjet DuraFlex de larga vida útil",
      "Secado rápido por Infrarrojo Cercano (NIR)",
      "Tintas pigmentadas base agua resistentes al agua y luz",
      "Apta para alimentos, bebidas y productos químicos",
      "Depósitos de tinta de 2L o 10L para producción continua"
    ],
    specs: [
      { label: "TIPO IMPRESIÓN", value: "CMYK en un solo cabezal" },
      { label: "RESOLUCIÓN", value: "1600x1600 dpi ó 1600x954 dpi" },
      { label: "ANCHO ROLLO MÁX", value: "38.1 cm (15\")" },
      { label: "ANCHO IMPRESIÓN", value: "32.38 cm (12.75\")" },
      { label: "DIÁMETRO ROLLO", value: "50 cm (19.7\")" },
      { label: "SUSTRATOS", value: "Papel brillante, PP, PET, PVC, BOPP, Mylar" }
    ],
    industries: ["Alimentos y Bebidas", "Químicos e Industriales", "Farmacéutica", "Limpieza del Hogar"]
  },
  {
    id: "vipcolor-vp610-vp660",
    name: "VIPColor VP610 / VP660",
    subtitle: "Impresoras Digitales de Escritorio Memjet Versapass",
    category: "impresoras",
    technology: "Memjet Versapass®",
    speed: "Hasta 18 m/min (305 mm/s)",
    resolution: "1600 x 1600 dpi",
    maxWidth: "20 cm (8\")",
    description: "Impresión de etiquetas a color bajo demanda para tirajes medianos. La VP660 incluye fórmula de tinta acuosa mejorada resistente a la humedad y salpicaduras.",
    badge: "MÁS POPULAR",
    image: "/imagenes/02-katun-dps-impresora-vp-610-660-web_-pdf-791x1024.jpg",
    pdfUrl: "/maquinas/02-katun-dps-impresora-vp-610-660-web_.pdf",
    features: [
      "Cabezal con 70,000 boquillas de micro-inyección",
      "Imprime hasta 2,400 etiquetas (4x6\") en solo 10 minutos",
      "Cartuchos de tinta individuales CMYK de 250ml",
      "Diseño compacto para laboratorio o línea de empaque",
      "Cero tiempos de preparación vs Flexografía"
    ],
    specs: [
      { label: "TECNOLOGÍA", value: "Memjet Versapass Single Pass" },
      { label: "VELOCIDAD ALTA RES", value: "9 m/min a 1600x1600 dpi" },
      { label: "ANCHO IMPRESIÓN", value: "20 cm (8\")" }
    ],
    industries: ["Alimentos Refrigerados", "Salud y Nutrición", "Cuidado Personal", "Cosmética"]
  },
  {
    id: "katun-lt330",
    name: "Katun DPS LT330 / Any-Press",
    subtitle: "Prensa Digital Compacta de Etiquetas LED High Definition",
    category: "impresoras",
    technology: "Digital LED HD",
    speed: "9.14 m/min",
    resolution: "1200 x 1200 dpi",
    maxWidth: "32 cm (12.6\")",
    description: "Solución de impresión digital de etiquetas versátil y económica, capaz de imprimir sobre una amplísima variedad de sustratos sin necesidad de tratamiento previo.",
    badge: "VERSATILIDAD LED",
    image: "/imagenes/any-press_katun-dps-01.webp",
    pdfUrl: "/maquinas/03-katun-dps-impresora-lt330-web-.pdf",
    features: [
      "Tecnología de fusión seca LED de alta definición",
      "Excelente adhesión en materiales sintéticos y estucados",
      "Fácil operación sin necesidad de técnico calificado",
      "Registro perfecto en etiquetas multicolor"
    ],
    specs: [
      { label: "RESOLUCIÓN", value: "1200 x 1200 dpi" },
      { label: "ANCHO DE BANDA", value: "330 mm" }
    ],
    industries: ["Etiquetas Industriales", "Señalamiento", "Bebidas y Vinos", "Empaques Pyme"]
  },
  {
    id: "aquajet-330-hybrid-pro-m",
    name: "Aqua Jet 330 Hybrid Pro M",
    subtitle: "Impresora Híbrida Digital + Acabado Integrado en Línea",
    category: "impresoras",
    technology: "Memjet DuraFlex® Híbrida",
    speed: "Hasta 21 m/min",
    resolution: "1600 x 1600 dpi",
    maxWidth: "32.4 cm (12.75\")",
    description: "El sistema todo-en-uno definitivo: imprime digitalmente en alta resolución, lamina en frío, corta con cuchilla/láser y retira el desperdicio en una sola pasada.",
    badge: "HÍBRIDA PRO",
    image: "/imagenes/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_-pdf-791x1024.jpg",
    pdfUrl: "/maquinas/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_.pdf",
    features: [
      "Proceso completo desde bobina en blanco a etiqueta terminada",
      "Módulo de laminado en frío sincronizado",
      "Sistema de corte de contorno de alta precisión integrado",
      "Rebobinador de matriz de desperdicio incorporado"
    ],
    specs: [
      { label: "IMPRESIÓN", value: "Digital CMYK Memjet DuraFlex" },
      { label: "LAMINADO", value: "Laminador en frío automático integrado" }
    ],
    industries: ["Vinos y Licores", "Farmacéutica", "Químicos GHS", "Empaques de Lujo"]
  },
  {
    id: "katun-klt3",
    name: "Katun KLT3 Industrial",
    subtitle: "Prensa Digital Inkjet para Etiquetas y Películas Flexibles",
    category: "impresoras",
    technology: "Inkjet Piezoeléctrico UV / Agua",
    speed: "Hasta 30 m/min",
    resolution: "1200 x 1200 dpi",
    maxWidth: "33 cm (13\")",
    description: "Impresora industrial robusta diseñada para operar 24/7 en entornos exigentes de conversión de etiqueta y empaque flexible.",
    badge: "INDUSTRIA 24/7",
    image: "/imagenes/hero-contacto-equipo-2.webp",
    pdfUrl: "/maquinas/05-katun-dps-impresora-klt3_web.pdf",
    features: [
      "Cabezales piezoeléctricos de gota variable",
      "Curado UV LED de baja temperatura",
      "Excelente opacidad en blanco y colores vibrantes",
      "Construcción en acero mecanizado de grado industrial"
    ],
    specs: [
      { label: "CABEZALES", value: "Piezoeléctricos industriales" },
      { label: "ANCHO BANDA", value: "330 mm" }
    ],
    industries: ["Empaques Flexibles", "Etiquetas Químicas", "Cosmética", "Decoración"]
  },
  {
    id: "aries-35pl",
    name: "Aries 35PL",
    subtitle: "Cortadora Digital de Etiquetas Semi-Rotativa de Alta Precisión",
    category: "cortadoras",
    technology: "Troquelado Semi-Rotativo Servo",
    speed: "Hasta 60 m/min",
    resolution: "Tolerancia ±0.1 mm",
    maxWidth: "35 cm (13.7\")",
    description: "Manejo avanzado de bobina con troquelado semi-rotativo servomotorizado. Permite utilizar cilindros de troquel magnético universales para acabados impecables.",
    badge: "SEMI-ROTATIVA",
    image: "/imagenes/aries-35plbrochure-web_compressed-pdf-791x1024.jpg",
    pdfUrl: "/maquinas/aries-35plbrochure-web_compressed.pdf",
    features: [
      "Velocidad de hasta 60 m/min en modo semi-rotativo",
      "Alineación óptica por lectura de marca de registro",
      "Unidad de laminado y despalillado de matriz",
      "Cuchillas longitudinales de corte de tiras (slitting)"
    ],
    specs: [
      { label: "ANCHO DE SUSTRATO", value: "350 mm" },
      { label: "VELOCIDAD MÁXIMA", value: "60 m/min" }
    ],
    industries: ["Convertidores de Etiquetas", "Imprentas Comerciales", "Empaque Flexible"]
  },
  {
    id: "arrow-ezcut-330rx",
    name: "Arrow EZCut 330RX",
    subtitle: "Sistema Digital de Acabado y Corte con Múltiples Cuchillas",
    category: "cortadoras",
    technology: "Cuchillas Neumáticas Digitales",
    speed: "Hasta 18 m/min",
    resolution: "Precisión 0.05 mm",
    maxWidth: "33 cm (13\")",
    description: "Estación de acabado digital compacta que integra laminación, corte de contorno continuo con múltiples cuchillas, refilado de bordes y doble rebobinado.",
    badge: "MULTI-CUCHILLA",
    image: "/imagenes/arrow-ezcut-330-rx-nuevo-2025-01.webp",
    pdfUrl: "/maquinas/arrow-ezcut-330rx-brochure-web_compressed.pdf",
    features: [
      "Corte continuo por archivo digital sin troqueles mecánicos",
      "Múltiples cabezales de corte simultáneos",
      "Laminado en frío incorporado",
      "Extracción automática de sobrante de etiqueta"
    ],
    specs: [
      { label: "ANCHO BANDA", value: "330 mm" },
      { label: "CABEZALES", value: "Hasta 4 cuchillas independientes" }
    ],
    industries: ["Etiquetas bajo demanda", "Microcervecerías", "Marcas Propias"]
  },
  {
    id: "arrow-ezcut-350r",
    name: "Arrow EZCut 350R Láser",
    subtitle: "Sistema de Acabado y Troquelado Láser Industrial",
    category: "cortadoras",
    technology: "Láser CO2 Galvanométrico",
    speed: "Hasta 50 m/min",
    resolution: "Submicrónica",
    maxWidth: "35 cm (13.7\")",
    description: "Corte digital por láser de alta potencia. Elimina por completo los costos y tiempos de espera de placas de troquel físico, permitiendo cambios de forma instantáneos.",
    badge: "CORTE LÁSER",
    image: "/imagenes/arrow-ezcut-350R-brochure-web-_compressed-pdf-791x1024.jpg",
    pdfUrl: "/maquinas/arrow-ezcut-350R-brochure-web-_compressed.pdf",
    features: [
      "Fuente láser CO2 galvanométrica de respuesta ultra-rápida",
      "Corte de formas complejas, microperforaciones y semicorte",
      "Cambio automático de trabajo por lectura de código QR",
      "Cero desgaste de componentes de corte"
    ],
    specs: [
      { label: "POTENCIA LÁSER", value: "100W / 150W CO2" },
      { label: "ANCHO DE TRABAJO", value: "350 mm" }
    ],
    industries: ["Farmacéutica", "Etiquetas de Seguridad", "Electrónica", "Cosmética High-End"]
  },
  {
    id: "arrow-ezcut-vr-240x",
    name: "Arrow EZCut VR 240X",
    subtitle: "Cortadora Digital Compacta para Etiquetas en Bobina",
    category: "cortadoras",
    technology: "Ploter de Cuchilla Drag Knife",
    speed: "6 m/min",
    resolution: "±0.1 mm",
    maxWidth: "24 cm (9.4\")",
    description: "Solución de acabado ligera y económica para pequeñas imprentas y talleres que buscan automatizar el corte de etiquetas impresas en VP610 o similares.",
    badge: "COMPACTA",
    image: "/imagenes/arrow-ezcut-vr-240xbrochure-web_compressed-pdf-791x1024.jpg",
    pdfUrl: "/maquinas/arrow-ezcut-vr-240xbrochure-web_compressed.pdf",
    features: [
      "Diseño compacto de escritorio",
      "Laminación en frío y rebobinado integrados",
      "Fácil importación de archivos de corte DXF/PLT",
      "Operación silenciosa y eficiente"
    ],
    specs: [
      { label: "ANCHO ROLLO", value: "240 mm" },
      { label: "VELOCIDAD CORTE", value: "Hasta 6 m/min" }
    ],
    industries: ["Pymes", "Emprendimientos", "Laboratorios de Pruebas"]
  },
  {
    id: "gemini-40",
    name: "Cortadora Gemini 40",
    subtitle: "Cortadora Digital de Etiquetas en Hojas y Bobinas Cortas",
    category: "cortadoras",
    technology: "Corte Digital por Hoja/Rollo",
    speed: "Hasta 12 m/min",
    resolution: "Cámara CCD Óptica",
    maxWidth: "35 cm x 50 cm",
    description: "Equipo versátil para cortar etiquetas tanto en pliegos/hojas como en rollos pequeños. Ideal para complementar prensas de hoja digital.",
    badge: "HOJAS Y ROLLO",
    image: "/imagenes/brochue-cortadora-de-etiquetas-gemini-40-pdf-791x1024.jpg",
    pdfUrl: "/maquinas/brochue-cortadora-de-etiquetas-gemini-40-.pdf",
    features: [
      "Alimentación automática de pliegos",
      "Cámara CCD para detección automática de marcas de registro",
      "Corte, semicorte y hendido en un solo paso",
      "Software intuitivo Gemini Cut Manager"
    ],
    specs: [
      { label: "FORMATO MÁX", value: "350 mm x 500 mm" },
      { label: "ALIMENTADOR", value: "Capacidad para 100 pliegos" }
    ],
    industries: ["Imprentas Digitales Sheetfed", "Diseño y Prototipado", "Cajas y Packaging"]
  },
  {
    id: "lc-350-pm",
    name: "Cortadora LC 350 PM Katun DPS",
    subtitle: "Sistema de Corte Láser Industrial de Alta Productividad",
    category: "cortadoras",
    technology: "Láser Galvanométrico Premium",
    speed: "Hasta 80 m/min",
    resolution: "Submicrónica",
    maxWidth: "35 cm (13.7\")",
    description: "El buque insignia en troquelado láser de Katun DPS. Diseñado para líneas de conversión industrial de alto rendimiento con código QR dinámico.",
    badge: "FLAGSHIP LÁSER",
    image: "/imagenes/hero-nosotros-expo-grafica.webp",
    pdfUrl: "/maquinas/cortadora-de-etiquetas-lc-350-pm-katun-dps_nuevo-web.pdf",
    features: [
      "Velocidad extrema de hasta 80 m/min",
      "Lectura QR al vuelo para cambio de diseño en microsegundos",
      "Módulo de barnizado UV e inspección de calidad opcional",
      "Construcción alemana / americana de alta durabilidad"
    ],
    specs: [
      { label: "TECNOLOGÍA LÁSER", value: "CO2 RF sellado galvanométrico" },
      { label: "VELOCIDAD MÁXIMA", value: "80 m/min" }
    ],
    industries: ["Converter Industrial", "Farmacéutica de Alto Volumen", "Bebidas Globales"]
  },
  {
    id: "kf30x",
    name: "Cortadora KF30X",
    subtitle: "Ploter Digital de Acabado de Etiquetas y Semicorte",
    category: "cortadoras",
    technology: "Cuchilla Tangencial Digital",
    speed: "12 m/min",
    resolution: "±0.05 mm",
    maxWidth: "30 cm (11.8\")",
    description: "Ploter de corte digital robusto con sistema de alineación láser y rebobinado de desecho para producciones continuas de etiquetado.",
    badge: "PRECISIÓN TANGENCIAL",
    image: "/imagenes/cortadora-kf30x-brochure-web-pdf-791x1024.jpg",
    pdfUrl: "/maquinas/cortadora-kf30x-brochure-web.pdf",
    features: [
      "Corte tangencial de gran precisión en esquinas complejas",
      "Laminador en frío con control de tensión de freno",
      "Estructura pesada antivibraciones"
    ],
    specs: [
      { label: "ANCHO TRABAJO", value: "300 mm" },
      { label: "VELOCIDAD", value: "12 m/min" }
    ],
    industries: ["Etiquetas Adhesivas", "Rotulación", "Packaging Personalizado"]
  },
  {
    id: "taurus-pl-series",
    name: "Taurus 25PL / 35PL / 35PL Plus",
    subtitle: "Plotters de Corte Digital con Platen de Vacío Multi-Zona",
    category: "cortadoras",
    technology: "Multi-Cuchilla Digital Servo",
    speed: "Hasta 30 m/min",
    resolution: "±0.05 mm",
    maxWidth: "35 cm (13.7\")",
    description: "Serie versátil de plotters de corte industrial disponibles en anchos de 250mm y 350mm con hasta 4 cabezales de corte independientes sincronizados.",
    badge: "VACUUM PLATEN",
    image: "/imagenes/dpr-taurus-35-pl-katun-dps-plus.webp",
    pdfUrl: "/maquinas/taurus-25-pl-35pl-35pl-plus-brochure-web_compressed.pdf",
    features: [
      "Platen de succión por vacío multi-zona para sujeción perfecta del sustrato",
      "Hasta 4 cabezales de corte trabajando en paralelo",
      "Ajuste digital de profundidad y presión por cabezal"
    ],
    specs: [
      { label: "MODELOS", value: "Taurus 25PL (250mm) / 35PL (350mm) / 35PL Plus" }
    ],
    industries: ["Producción Comercial", "Etiquetas de Alimentos", "Químicos"]
  },
  {
    id: "contador-automatico",
    name: "Contador Automático de Etiquetas Katun",
    subtitle: "Equipo de Inspección, Conteo y Rebobinado de Precisión",
    category: "especiales",
    technology: "Sensor Ultrasónico + Fotoeléctrico",
    speed: "Hasta 300 m/min",
    resolution: "100% Precisión",
    maxWidth: "35 cm (13.7\")",
    description: "Unidad indispensable para el control de calidad final. Cuenta con precisión absoluta etiquetas opacas, transparentes y metálicas a alta velocidad.",
    badge: "CONTROL QA",
    image: "/imagenes/KATUN-DPS-Catalogo-01-28-2025_web-pdf-791x1024.jpg",
    pdfUrl: "/maquinas/contador-de-automatico-de-etiquetas-web_red.pdf",
    features: [
      "Detección ultrasónica para etiquetas transparentes / clear-on-clear",
      "Conteo por número de etiquetas o por metros lineales",
      "Paro automático al alcanzar el conteo programado"
    ],
    specs: [
      { label: "VELOCIDAD MÁXIMA", value: "300 m/min" },
      { label: "SENSORES", value: "Óptico fotoeléctrico + Ultrasónico de brecha" }
    ],
    industries: ["Control de Calidad", "Inspección Final", "Farmacéutica GXP"]
  }
];
