import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://dwnlsbilmlvflazkvunt.supabase.co';
const supabaseKey = 'sb_publishable_nskswntjGcJaL3W3dfeWKg_UvmT0T2t';

const supabase = createClient(supabaseUrl, supabaseKey);

const INDUSTRIES_DATA = [
  {
    slug: 'bebidas',
    title: 'Industria de Bebidas',
    tag: 'VINO, CERVEZA & DESTILADOS',
    icon: 'wine_bar',
    image: 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?auto=format&fit=crop&w=800&q=80',
    description: 'Ofrecemos una amplia variedad de tecnología de impresión de etiquetas que permite a nuestros clientes imprimir y cortar fácilmente sus propias etiquetas de vino o cerveza. ¿Buscas darle a tu etiqueta un poco más de pop? ¡Tenemos una amplia variedad de materiales especiales que ayudarán a que su marca se destaque en el estante! Imprima sus propias etiquetas de cerveza personalizadas y etiquetas de vino personalizadas cuando las necesite. Se acabaron las cantidades mínimas de pedido o las primas para las etiquetas de tiradas cortas. Imprima solo lo que necesita para no tener que mantener un inventario de etiquetas preimpresas.',
    subsections: ['Vino y Cerveza Artesanal', 'Sin Mínimos de Pedido', 'Sustratos Especiales & Texturizados', 'Resistencia a Humedad y Hielo']
  },
  {
    slug: 'química',
    title: 'Industria Química',
    tag: 'ETIQUETADO GHS & BS5609',
    icon: 'science',
    image: 'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=800&q=80',
    description: 'En lo que respecta a las etiquetas químicas, la impresión digital es flexible. Esta flexibilidad le permite ajustar su etiqueta a medida que cambian las condiciones que rodean la industria. Ya sea que se trate de nuevas pautas sobre el manejo o de un nuevo color para encajar en el sistema armonizado, su empresa ahora tiene la capacidad de adaptarse e imprimir exactamente lo que busca su cliente. Esta poderosa máquina de impresión de inyección de tinta utiliza tintas pigmentadas acuosas que brindan no solo durabilidad, sino también una impresionante recompensa de color que contará con una longevidad durante toda su vida útil. Obtenga más información sobre ArrowJet Aqua 330R aquí hoy y comuníquese para obtener más información.',
    subsections: ['Etiquetas para Químicos', 'Empaques Flexibles', 'Cumplimiento GHS y OSHA', 'Tintas Pigmentadas de Alta Resistencia']
  },
  {
    slug: 'comestibles',
    title: 'Industria de Comestibles',
    tag: 'EMPAQUES FLEXIBLES & MYLAR',
    icon: 'shopping_bag',
    image: 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?auto=format&fit=crop&w=800&q=80',
    description: '¡Ofrecemos una amplia gama de equipos para producir empaques flexibles para una variedad de industrias que incluyen empaques de alimentos, empaques farmacéuticos, bolsas de café, comestibles de cannabis y más! Lo ayudaremos a crear una solución llave en mano para las necesidades de empaque flexible de su empresa en función del volumen de bolsas de mylar que necesita producir y su presupuesto para el proyecto. Además de las impresoras y los materiales, lo ayudaremos a ubicar el equipo VFFS o HFFS adecuado para llenar y sellar su empaque. Ya sea una solución que ofrecemos lista para usar o una creación personalizada, tenemos la capacidad de ayudar a impulsar el crecimiento de su empresa a través de soluciones de empaque flexible personalizadas.',
    subsections: ['Empaques de Alimentos y Café', 'Comestibles de Cannabis', 'Bolsas Mylar Personalizadas', 'Integración con Equipos VFFS / HFFS']
  },
  {
    slug: 'productos-varios',
    title: 'Industria de Productos Varios',
    tag: 'ON-DEMAND & CORTO TIRAJE',
    icon: 'inventory_2',
    image: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=800&q=80',
    description: 'Nuestros sistemas le permiten imprimir lo que necesita bajo demanda. Ya sea que necesite imprimir 1 etiqueta o 10,000 etiquetas, tenemos un sistema que funcionará para las necesidades de su negocio. ¡No es necesario esperar a que un proveedor de etiquetas le envíe etiquetas para sus productos cuando puede lograr el mismo nivel de producción de etiquetas internamente por mucho menos! Con la capacidad de personalizar fácilmente las etiquetas de su empresa para una producción corta, ¡nuestros sistemas de impresión de etiquetas permiten una mayor flexibilidad en cualquier proyecto!',
    subsections: ['Etiquetas para Embalaje', 'Etiquetado Farmacéutica', 'Producción Interna In-House', 'Impresión de 1 a 10,000 Etiquetas']
  },
  {
    slug: 'farmaceutica',
    title: 'Industria Farmacéutica',
    tag: 'TRAZABILIDAD & LAMINADOS',
    icon: 'medication',
    image: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=800&q=80',
    description: 'Las nuevas tecnologías, como los envases flexibles, las tintas de alta calidad y los envases laminados, permiten a las empresas farmacéuticas adaptarse rápidamente según sea necesario. La impresión digital ha ofrecido a muchas industrias la oportunidad de imprimir solo la cantidad necesaria y, en última instancia, reducir sus costos de inventario. Esto ayuda a medida que las empresas avanzan y continúan implementando nuevos diseños independientemente de los cambios en las regulaciones o las preferencias de los clientes.',
    subsections: ['Envases Laminados', 'Tintas de Alta Calidad', 'Optimización de Inventario', 'Flexibilidad Regulatoria']
  },
  {
    slug: 'grafica',
    title: 'Industria Gráfica',
    tag: 'SEÑALÉTICA & MATERIALES ESPECIALES',
    icon: 'palette',
    image: 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=800&q=80',
    description: 'Desde sus inicios, Arrow Systems Inc. ha mantenido relaciones sólidas y duraderas con muchas de las marcas más confiables y respetadas de la industria de letreros y gráficos, como Gerber Technology. Esto ha permitido a nuestros clientes tener acceso a las tecnologías más avanzadas junto con nuestro principal sistema de distribución y atención al cliente. Utilizando la última tecnología de impresión disponible, nuestros sistemas le permiten diseñar e imprimir cualquier cosa que pueda imaginar en láminas de fibrocemento o baldosas de cerámica.',
    subsections: ['Señalética y Similares', 'Etiquetas para las Industrias', 'Sustratos Rígidos (Fibrocemento/Cerámica)', 'Tecnología Gerber Technology']
  },
  {
    slug: 'fabricacion',
    title: 'Fabricación e Industria',
    tag: 'NORMATIVAS OSHA, UL, GHS, ANSI',
    icon: 'precision_manufacturing',
    image: 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80',
    description: 'Arrow system Inc. cuenta con múltiples sistemas para la creación de etiquetas industriales y químicas. Ya sea que esté buscando crear etiquetas para equipos, fabricación de productos químicos o sistemas de etiquetado a nivel de producción, Arrow tiene las opciones de impresión y acabado adecuadas para satisfacer sus necesidades. Tenemos impresoras que crean etiquetas para las pautas más estrictas. Ya sea que se trate de la certificación OSHA, UL, GHS o ANSI, tenemos un sistema que cumplirá con las especificaciones necesarias.',
    subsections: ['Etiquetas para Equipos', 'Certificaciones OSHA, UL, GHS, ANSI', 'Producción Continuada', 'Prensas Digitales y Acabadores']
  }
];

const PRODUCTS_DATA = [
  {
    slug: "arrowjet-aqua-330r",
    name: "ArrowJet Aqua 330R",
    subtitle: "Impresora Digital de Etiquetas Rollo a Rollo de Alta Velocidad",
    category: "impresoras",
    technology: "Memjet DuraFlex®",
    speed: "Hasta 21 m/min (69 ft/min)",
    resolution: "1600 x 1600 dpi",
    max_width: "32.38 cm (12.75\")",
    description: "Impresora industrial de alta producción con tintas pigmentadas en base agua. Diseñada para tirajes medianos y largos con secado NIR (Near InfraRed) instantáneo.",
    badge: "MÁXIMA VELOCIDAD",
    image: "/imagenes/arrow-jet-aqua-330R-01.webp",
    pdf_url: "/maquinas/01-katun-dps-impresora-aqua-330r-web-2_.pdf",
    features: [
      "Cabezal Memjet DuraFlex de larga vida útil",
      "Secado rápido por Infrarrojo Cercano (NIR)",
      "Tintas pigmentadas base agua resistentes al agua y luz",
      "Apta para alimentos, bebidas y productos químicos"
    ],
    specs: [
      { label: "TIPO IMPRESIÓN", value: "CMYK en un solo cabezal" },
      { label: "RESOLUCIÓN", value: "1600x1600 dpi" }
    ]
  },
  {
    slug: "vipcolor-vp610-vp660",
    name: "VIPColor VP610 / VP660",
    subtitle: "Impresoras Digitales de Escritorio Memjet Versapass",
    category: "impresoras",
    technology: "Memjet Versapass®",
    speed: "Hasta 18 m/min (305 mm/s)",
    resolution: "1600 x 1600 dpi",
    max_width: "20 cm (8\")",
    description: "Impresión de etiquetas a color bajo demanda para tirajes medianos. La VP660 incluye fórmula de tinta acuosa mejorada resistente a la humedad y salpicaduras.",
    badge: "MÁS POPULAR",
    image: "/imagenes/02-katun-dps-impresora-vp-610-660-web_-pdf-791x1024.jpg",
    pdf_url: "/maquinas/02-katun-dps-impresora-vp-610-660-web_.pdf",
    features: [
      "Cabezal con 70,000 boquillas de micro-inyección",
      "Imprime hasta 2,400 etiquetas (4x6\") en solo 10 minutos"
    ],
    specs: [
      { label: "TECNOLOGÍA", value: "Memjet Versapass Single Pass" }
    ]
  },
  {
    slug: "katun-lt330",
    name: "Katun DPS LT330 / Any-Press",
    subtitle: "Prensa Digital Compacta de Etiquetas LED High Definition",
    category: "impresoras",
    technology: "Digital LED HD",
    speed: "9.14 m/min",
    resolution: "1200 x 1200 dpi",
    max_width: "32 cm (12.6\")",
    description: "Solución de impresión digital de etiquetas versátil y económica, capaz de imprimir sobre una amplísima variedad de sustratos sin necesidad de tratamiento previo.",
    badge: "VERSATILIDAD LED",
    image: "/imagenes/any-press_katun-dps-01.webp",
    pdf_url: "/maquinas/03-katun-dps-impresora-lt330-web-.pdf",
    features: [
      "Tecnología de fusión seca LED de alta definición",
      "Excelente adhesión en materiales sintéticos y estucados"
    ],
    specs: [
      { label: "RESOLUCIÓN", value: "1200 x 1200 dpi" }
    ]
  },
  {
    slug: "aquajet-330-hybrid-pro-m",
    name: "Aqua Jet 330 Hybrid Pro M",
    subtitle: "Impresora Híbrida Digital + Acabado Integrado en Línea",
    category: "impresoras",
    technology: "Memjet DuraFlex® Híbrida",
    speed: "Hasta 21 m/min",
    resolution: "1600 x 1600 dpi",
    max_width: "32.4 cm (12.75\")",
    description: "El sistema todo-en-uno definitivo: imprime digitalmente en alta resolución, lamina en frío, corta con cuchilla/láser y retira el desperdicio en una sola pasada.",
    badge: "HÍBRIDA PRO",
    image: "/imagenes/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_-pdf-791x1024.jpg",
    pdf_url: "/maquinas/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_.pdf",
    features: [
      "Proceso completo desde bobina en blanco a etiqueta terminada",
      "Módulo de laminado en frío sincronizado"
    ],
    specs: [
      { label: "IMPRESIÓN", value: "Digital CMYK Memjet DuraFlex" }
    ]
  },
  {
    slug: "katun-klt3",
    name: "Katun KLT3 Industrial",
    subtitle: "Prensa Digital Inkjet para Etiquetas y Películas Flexibles",
    category: "impresoras",
    technology: "Inkjet Piezoeléctrico UV / Agua",
    speed: "Hasta 30 m/min",
    resolution: "1200 x 1200 dpi",
    max_width: "33 cm (13\")",
    description: "Impresora industrial robusta diseñada para operar 24/7 en entornos exigentes de conversión de etiqueta y empaque flexible.",
    badge: "INDUSTRIA 24/7",
    image: "/imagenes/hero-contacto-equipo-2.webp",
    pdf_url: "/maquinas/05-katun-dps-impresora-klt3_web.pdf",
    features: [
      "Cabezales piezoeléctricos de gota variable",
      "Curado UV LED de baja temperatura"
    ],
    specs: [
      { label: "CABEZALES", value: "Piezoeléctricos industriales" }
    ]
  },
  {
    slug: "aries-35pl",
    name: "Aries 35PL",
    subtitle: "Cortadora Digital de Etiquetas Semi-Rotativa de Alta Precisión",
    category: "cortadoras",
    technology: "Troquelado Semi-Rotativo Servo",
    speed: "Hasta 60 m/min",
    resolution: "Tolerancia ±0.1 mm",
    max_width: "35 cm (13.7\")",
    description: "Manejo avanzado de bobina con troquelado semi-rotativo servomotorizado. Permite utilizar cilindros de troquel magnético universales para acabados impecables.",
    badge: "SEMI-ROTATIVA",
    image: "/imagenes/aries-35plbrochure-web_compressed-pdf-791x1024.jpg",
    pdf_url: "/maquinas/aries-35plbrochure-web_compressed.pdf",
    features: [
      "Velocidad de hasta 60 m/min en modo semi-rotativo",
      "Alineación óptica por lectura de marca de registro"
    ],
    specs: [
      { label: "ANCHO DE SUSTRATO", value: "350 mm" }
    ]
  },
  {
    slug: "arrow-ezcut-330rx",
    name: "Arrow EZCut 330RX",
    subtitle: "Sistema Digital de Acabado y Corte con Múltiples Cuchillas",
    category: "cortadoras",
    technology: "Cuchillas Neumáticas Digitales",
    speed: "Hasta 18 m/min",
    resolution: "Precisión 0.05 mm",
    max_width: "33 cm (13\")",
    description: "Estación de acabado digital compacta que integra laminación, corte de contorno continuo con múltiples cuchillas, refilado de bordes y doble rebobinado.",
    badge: "MULTI-CUCHILLA",
    image: "/imagenes/arrow-ezcut-330-rx-nuevo-2025-01.webp",
    pdf_url: "/maquinas/arrow-ezcut-330rx-brochure-web_compressed.pdf",
    features: [
      "Corte continuo por archivo digital sin troqueles mecánicos",
      "Múltiples cabezales de corte simultáneos"
    ],
    specs: [
      { label: "ANCHO BANDA", value: "330 mm" }
    ]
  },
  {
    slug: "arrow-ezcut-350r",
    name: "Arrow EZCut 350R Láser",
    subtitle: "Sistema de Acabado y Troquelado Láser Industrial",
    category: "cortadoras",
    technology: "Láser CO2 Galvanométrico",
    speed: "Hasta 50 m/min",
    resolution: "Submicrónica",
    max_width: "35 cm (13.7\")",
    description: "Corte digital por láser de alta potencia. Elimina por completo los costos y tiempos de espera de placas de troquel físico, permitiendo cambios de forma instantáneos.",
    badge: "CORTE LÁSER",
    image: "/imagenes/arrow-ezcut-350R-brochure-web-_compressed-pdf-791x1024.jpg",
    pdf_url: "/maquinas/arrow-ezcut-350R-brochure-web-_compressed.pdf",
    features: [
      "Fuente láser CO2 galvanométrica de respuesta ultra-rápida",
      "Corte de formas complejas y microperforaciones"
    ],
    specs: [
      { label: "POTENCIA LÁSER", value: "100W / 150W CO2" }
    ]
  },
  {
    slug: "arrow-ezcut-vr-240x",
    name: "Arrow EZCut VR 240X",
    subtitle: "Cortadora Digital Compacta para Etiquetas en Bobina",
    category: "cortadoras",
    technology: "Ploter de Cuchilla Drag Knife",
    speed: "6 m/min",
    resolution: "±0.1 mm",
    max_width: "24 cm (9.4\")",
    description: "Solución de acabado ligera y económica para pequeñas imprentas y talleres que buscan automatizar el corte de etiquetas impresas en VP610 o similares.",
    badge: "COMPACTA",
    image: "/imagenes/arrow-ezcut-vr-240xbrochure-web_compressed-pdf-791x1024.jpg",
    pdf_url: "/maquinas/arrow-ezcut-vr-240xbrochure-web_compressed.pdf",
    features: [
      "Diseño compacto de escritorio",
      "Laminación en frío y rebobinado integrados"
    ],
    specs: [
      { label: "ANCHO ROLLO", value: "240 mm" }
    ]
  },
  {
    slug: "gemini-40",
    name: "Cortadora Gemini 40",
    subtitle: "Cortadora Digital de Etiquetas en Hojas y Bobinas Cortas",
    category: "cortadoras",
    technology: "Corte Digital por Hoja/Rollo",
    speed: "Hasta 12 m/min",
    resolution: "Cámara CCD Óptica",
    max_width: "35 cm x 50 cm",
    description: "Equipo versátil para cortar etiquetas tanto en pliegos/hojas como en rollos pequeños. Ideal para complementar prensas de hoja digital.",
    badge: "HOJAS Y ROLLO",
    image: "/imagenes/brochue-cortadora-de-etiquetas-gemini-40-pdf-791x1024.jpg",
    pdf_url: "/maquinas/brochue-cortadora-de-etiquetas-gemini-40-.pdf",
    features: [
      "Alimentación automática de pliegos",
      "Cámara CCD para detección automática de marcas de registro"
    ],
    specs: [
      { label: "FORMATO MÁX", value: "350 mm x 500 mm" }
    ]
  },
  {
    slug: "lc-350-pm",
    name: "Cortadora LC 350 PM Katun DPS",
    subtitle: "Sistema de Corte Láser Industrial de Alta Productividad",
    category: "cortadoras",
    technology: "Láser Galvanométrico Premium",
    speed: "Hasta 80 m/min",
    resolution: "Submicrónica",
    max_width: "35 cm (13.7\")",
    description: "El buque insignia en troquelado láser de Katun DPS. Diseñado para líneas de conversión industrial de alto rendimiento con código QR dinámico.",
    badge: "FLAGSHIP LÁSER",
    image: "/imagenes/hero-nosotros-expo-grafica.webp",
    pdf_url: "/maquinas/cortadora-de-etiquetas-lc-350-pm-katun-dps_nuevo-web.pdf",
    features: [
      "Velocidad extrema de hasta 80 m/min",
      "Lectura QR al vuelo para cambio de diseño en microsegundos"
    ],
    specs: [
      { label: "TECNOLOGÍA LÁSER", value: "CO2 RF sellado galvanométrico" }
    ]
  },
  {
    slug: "kf30x",
    name: "Cortadora KF30X",
    subtitle: "Ploter Digital de Acabado de Etiquetas y Semicorte",
    category: "cortadoras",
    technology: "Cuchilla Tangencial Digital",
    speed: "12 m/min",
    resolution: "±0.05 mm",
    max_width: "30 cm (11.8\")",
    description: "Ploter de corte digital robusto con sistema de alineación láser y rebobinado de desecho para producciones continuas de etiquetado.",
    badge: "PRECISIÓN TANGENCIAL",
    image: "/imagenes/cortadora-kf30x-brochure-web-pdf-791x1024.jpg",
    pdf_url: "/maquinas/cortadora-kf30x-brochure-web.pdf",
    features: [
      "Corte tangencial de gran precisión en esquinas complejas",
      "Laminador en frío con control de tensión de freno"
    ],
    specs: [
      { label: "ANCHO TRABAJO", value: "300 mm" }
    ]
  },
  {
    slug: "taurus-pl-series",
    name: "Taurus 25PL / 35PL / 35PL Plus",
    subtitle: "Plotters de Corte Digital con Platen de Vacío Multi-Zona",
    category: "cortadoras",
    technology: "Multi-Cuchilla Digital Servo",
    speed: "Hasta 30 m/min",
    resolution: "±0.05 mm",
    max_width: "35 cm (13.7\")",
    description: "Serie versátil de plotters de corte industrial disponibles en anchos de 250mm y 350mm con hasta 4 cabezales de corte independientes sincronizados.",
    badge: "VACUUM PLATEN",
    image: "/imagenes/dpr-taurus-35-pl-katun-dps-plus.webp",
    pdf_url: "/maquinas/taurus-25-pl-35pl-35pl-plus-brochure-web_compressed.pdf",
    features: [
      "Platen de succión por vacío multi-zona para sujeción perfecta del sustrato",
      "Hasta 4 cabezales de corte trabajando en paralelo"
    ],
    specs: [
      { label: "MODELOS", value: "Taurus 25PL (250mm) / 35PL (350mm) / 35PL Plus" }
    ]
  },
  {
    slug: "contador-automatico",
    name: "Contador Automático de Etiquetas Katun",
    subtitle: "Equipo de Inspección, Conteo y Rebobinado de Precisión",
    category: "especiales",
    technology: "Sensor Ultrasónico + Fotoeléctrico",
    speed: "Hasta 300 m/min",
    resolution: "100% Precisión",
    max_width: "35 cm (13.7\")",
    description: "Unidad indispensable para el control de calidad final. Cuenta con precisión absoluta etiquetas opacas, transparentes y metálicas a alta velocidad.",
    badge: "CONTROL QA",
    image: "/imagenes/KATUN-DPS-Catalogo-01-28-2025_web-pdf-791x1024.jpg",
    pdf_url: "/maquinas/contador-de-automatico-de-etiquetas-web_red.pdf",
    features: [
      "Detección ultrasónica para etiquetas transparentes / clear-on-clear",
      "Conteo por número de etiquetas o por metros lineales"
    ],
    specs: [
      { label: "VELOCIDAD MÁXIMA", value: "300 m/min" }
    ]
  }
];

async function seed() {
  console.log('🚀 Enviando imágenes y brochures locales a Supabase...');

  const { data: indRes, error: indErr } = await supabase
    .from('industries')
    .upsert(INDUSTRIES_DATA, { onConflict: 'slug' });

  if (indErr) console.error('❌ Error industrias:', indErr.message);

  const { data: prodRes, error: prodErr } = await supabase
    .from('products')
    .upsert(PRODUCTS_DATA, { onConflict: 'slug' });

  if (prodErr) {
    console.error('❌ Error productos:', prodErr.message);
  } else {
    console.log('✅ Los 14 equipos se actualizaron en Supabase con sus imágenes y PDFs locales.');
  }

  console.log('🏁 Completado.');
}

seed();
