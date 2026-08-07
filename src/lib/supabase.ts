import { createClient, type SupabaseClient } from '@supabase/supabase-js';
import { MACHINES, type Machine } from '../data/machines';

// Configuración de URL y ANON KEY desde variables de entorno
const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL || import.meta.env.SUPABASE_URL || 'https://dwnlsbilmlvflazkvunt.supabase.co';
const supabaseKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY || import.meta.env.SUPABASE_KEY || 'sb_publishable_nskswntjGcJaL3W3dfeWKg_UvmT0T2t';

export let supabase: SupabaseClient | null = null;

try {
  if (supabaseUrl && supabaseKey) {
    supabase = createClient(supabaseUrl, supabaseKey);
  }
} catch (e) {
  console.warn('No se pudo inicializar el cliente de Supabase, se utilizarán los datos locales fallback.', e);
}

export interface IndustryData {
  id?: string;
  slug: string;
  title: string;
  tag: string;
  icon: string;
  image: string;
  description: string;
  subsections?: string[];
  recommendedMachines?: string[];
}

export interface CatalogData {
  id: string;
  title: string;
  description: string;
  pdf_url: string;
  category: string;
  product_slug?: string;
}

// Fallback de Industrias locales con la información exacta proporcionada
export const LOCAL_INDUSTRIES: IndustryData[] = [
  {
    slug: 'bebidas',
    title: 'Industria de Bebidas',
    tag: 'VINO, CERVEZA & DESTILADOS',
    icon: 'wine_bar',
    image: 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?auto=format&fit=crop&w=800&q=80',
    description: 'Ofrecemos una amplia variedad de tecnología de impresión de etiquetas que permite a nuestros clientes imprimir y cortar fácilmente sus propias etiquetas de vino o cerveza. ¿Buscas darle a tu etiqueta un poco más de pop? ¡Tenemos una amplia variedad de materiales especiales que ayudarán a que su marca se destaque en el estante! Imprima sus propias etiquetas de cerveza personalizadas y etiquetas de vino personalizadas cuando las necesite. Se acabaron las cantidades mínimas de pedido o las primas para las etiquetas de tiradas cortas. Imprima solo lo que necesita para no tener que mantener un inventario de etiquetas preimpresas.',
    subsections: ['Vino y Cerveza Artesanal', 'Sin Mínimos de Pedido', 'Sustratos Especiales & Texturizados', 'Resistencia a Humedad y Hielo'],
    recommendedMachines: ['ArrowJet Aqua 330R', 'VIPColor VP610', 'Katun DPS LT330']
  },
  {
    slug: 'química',
    title: 'Industria Química',
    tag: 'ETIQUETADO GHS & BS5609',
    icon: 'science',
    image: 'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=800&q=80',
    description: 'En lo que respecta a las etiquetas químicas, la impresión digital es flexible. Esta flexibilidad le permite ajustar su etiqueta a medida que cambian las condiciones que rodean la industria. Ya sea que se trate de nuevas pautas sobre el manejo o de un nuevo color para encajar en el sistema armonizado, su empresa ahora tiene la capacidad de adaptarse e imprimir exactamente lo que busca su cliente. Esta poderosa máquina de impresión de inyección de tinta utiliza tintas pigmentadas acuosas que brindan no solo durabilidad, sino también una impresionante recompensa de color que contará con una longevidad durante toda su vida útil. Obtenga más información sobre ArrowJet Aqua 330R aquí hoy y comuníquese para obtener más información.',
    subsections: ['Etiquetas para Químicos', 'Empaques Flexibles', 'Cumplimiento GHS y OSHA', 'Tintas Pigmentadas de Alta Resistencia'],
    recommendedMachines: ['ArrowJet Aqua 330R', 'Arrow EZCut 350R Láser', 'LC 350 PM']
  },
  {
    slug: 'comestibles',
    title: 'Industria de Comestibles',
    tag: 'EMPAQUES FLEXIBLES & MYLAR',
    icon: 'shopping_bag',
    image: 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?auto=format&fit=crop&w=800&q=80',
    description: '¡Ofrecemos una amplia gama de equipos para producir empaques flexibles para una variedad de industrias que incluyen empaques de alimentos, empaques farmacéuticos, bolsas de café, comestibles de cannabis y más! Lo ayudaremos a crear una solución llave en mano para las necesidades de empaque flexible de su empresa en función del volumen de bolsas de mylar que necesita producir y su presupuesto para el proyecto. Además de las impresoras y los materiales, lo ayudaremos a ubicar el equipo VFFS o HFFS adecuado para llenar y sellar su empaque. Ya sea una solución que ofrecemos lista para usar o una creación personalizada, tenemos la capacidad de ayudar a impulsar el crecimiento de su empresa a través de soluciones de empaque flexible personalizadas.',
    subsections: ['Empaques de Alimentos y Café', 'Comestibles de Cannabis', 'Bolsas Mylar Personalizadas', 'Integración con Equipos VFFS / HFFS'],
    recommendedMachines: ['Katun KLT3', 'Gemini 40', 'VIPColor VP660']
  },
  {
    slug: 'productos-varios',
    title: 'Industria de Productos Varios',
    tag: 'ON-DEMAND & CORTO TIRAJE',
    icon: 'inventory_2',
    image: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=800&q=80',
    description: 'Nuestros sistemas le permiten imprimir lo que necesita bajo demanda. Ya sea que necesite imprimir 1 etiqueta o 10,000 etiquetas, tenemos un sistema que funcionará para las necesidades de su negocio. ¡No es necesario esperar a que un proveedor de etiquetas le envíe etiquetas para sus productos cuando puede lograr el mismo nivel de producción de etiquetas internamente por mucho menos! Con la capacidad de personalizar fácilmente las etiquetas de su empresa para una producción corta, ¡nuestros sistemas de impresión de etiquetas permiten una mayor flexibilidad en cualquier proyecto!',
    subsections: ['Etiquetas para Embalaje', 'Etiquetado Farmacéutica', 'Producción Interna In-House', 'Impresión de 1 a 10,000 Etiquetas'],
    recommendedMachines: ['VIPColor VP610', 'Katun DPS LT330', 'Aries 35PL']
  },
  {
    slug: 'farmaceutica',
    title: 'Industria Farmacéutica',
    tag: 'TRAZABILIDAD & LAMINADOS',
    icon: 'medication',
    image: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=800&q=80',
    description: 'Las nuevas tecnologías, como los envases flexibles, las tintas de alta calidad y los envases laminados, permiten a las empresas farmacéuticas adaptarse rápidamente según sea necesario. La impresión digital ha ofrecido a muchas industrias la oportunidad de imprimir solo la cantidad necesaria y, en última instancia, reducir sus costos de inventario. Esto ayuda a medida que las empresas avanzan y continúan implementando nuevos diseños independientemente de los cambios en las regulaciones o las preferencias de los clientes.',
    subsections: ['Envases Laminados', 'Tintas de Alta Calidad', 'Optimización de Inventario', 'Flexibilidad Regulatoria'],
    recommendedMachines: ['VIPColor VP660', 'LC 350 PM Láser', 'Contador Automático']
  },
  {
    slug: 'grafica',
    title: 'Industria Gráfica',
    tag: 'SEÑALÉTICA & MATERIALES ESPECIALES',
    icon: 'palette',
    image: 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=800&q=80',
    description: 'Desde sus inicios, Arrow Systems Inc. ha mantenido relaciones sólidas y duraderas con muchas de las marcas más confiables y respetadas de la industria de letreros y gráficos, como Gerber Technology. Esto ha permitido a nuestros clientes tener acceso a las tecnologías más avanzadas junto con nuestro principal sistema de distribución y atención al cliente. Utilizando la última tecnología de impresión disponible, nuestros sistemas le permiten diseñar e imprimir cualquier cosa que pueda imaginar en láminas de fibrocemento o baldosas de cerámica.',
    subsections: ['Señalética y Similares', 'Etiquetas para las Industrias', 'Sustratos Rígidos (Fibrocemento/Cerámica)', 'Tecnología Gerber Technology'],
    recommendedMachines: ['Katun KLT3', 'Arrow EZCut 330RX', 'Katun LT330']
  },
  {
    slug: 'fabricacion',
    title: 'Fabricación e Industria',
    tag: 'NORMATIVAS OSHA, UL, GHS, ANSI',
    icon: 'precision_manufacturing',
    image: 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80',
    description: 'Arrow system Inc. cuenta con múltiples sistemas para la creación de etiquetas industriales y químicas. Ya sea que esté buscando crear etiquetas para equipos, fabricación de productos químicos o sistemas de etiquetado a nivel de producción, Arrow tiene las opciones de impresión y acabado adecuadas para satisfacer sus necesidades. Tenemos impresoras que crean etiquetas para las pautas más estrictas. Ya sea que se trate de la certificación OSHA, UL, GHS o ANSI, tenemos un sistema que cumplirá con las especificaciones necesarias.',
    subsections: ['Etiquetas para Equipos', 'Certificaciones OSHA, UL, GHS, ANSI', 'Producción Continuada', 'Prensas Digitales y Acabadores'],
    recommendedMachines: ['ArrowJet Aqua 330R', 'Katun DPS LT330', 'LC 350 PM']
  }
];

// Función para obtener las industrias desde Supabase (con fallback)
export async function getIndustries(): Promise<IndustryData[]> {
  if (!supabase) return LOCAL_INDUSTRIES;
  try {
    // Consultar la tabla maestra DPS_MX filtrando por record_type = 'industria'
    let { data, error } = await supabase
      .from('DPS_MX')
      .select('*')
      .eq('record_type', 'industria')
      .order('created_at', { ascending: true });
    
    // Fallbacks preventivos por compatibilidad
    if (error || !data || data.length === 0) {
      const fb1 = await supabase.from('dps_mx_industries').select('*').order('created_at', { ascending: true });
      data = fb1.data;
    }
    if (!data || data.length === 0) {
      const fb2 = await supabase.from('industries').select('*').order('created_at', { ascending: true });
      data = fb2.data;
    }

    if (!data || data.length === 0) {
      console.info('Utilizando industrias locales (fallo en Supabase o tabla vacía).');
      return LOCAL_INDUSTRIES;
    }
    return data.map((item: any) => ({
      id: item.id,
      slug: item.slug,
      title: item.title,
      tag: item.tag,
      icon: item.icon,
      image: item.image,
      description: item.description,
      subsections: Array.isArray(item.subsections) ? item.subsections : [],
      recommendedMachines: LOCAL_INDUSTRIES.find(i => i.slug === item.slug)?.recommendedMachines || ['ArrowJet Aqua 330R', 'Katun DPS LT330']
    }));
  } catch (err) {
    console.error('Error al conectar con Supabase para obtener industrias:', err);
    return LOCAL_INDUSTRIES;
  }
}

// Función para obtener los productos desde Supabase (con fallback)
export async function getProducts(): Promise<Machine[]> {
  if (!supabase) return MACHINES;
  try {
    // Consultar la tabla maestra DPS_MX filtrando por record_type = 'producto'
    let { data, error } = await supabase
      .from('DPS_MX')
      .select('*')
      .eq('record_type', 'producto');
    
    // Fallbacks preventivos por compatibilidad
    if (error || !data || data.length === 0) {
      const fb1 = await supabase.from('dps_mx_products').select('*');
      data = fb1.data;
    }
    if (!data || data.length === 0) {
      const fb2 = await supabase.from('products').select('*');
      data = fb2.data;
    }

    if (!data || data.length === 0) {
      return MACHINES;
    }
    return data.map((item: any) => ({
      id: item.slug || item.id,
      name: item.name,
      subtitle: item.subtitle,
      category: item.category,
      technology: item.technology,
      speed: item.speed,
      resolution: item.resolution,
      maxWidth: item.max_width || item.maxWidth,
      description: item.description,
      features: Array.isArray(item.features) ? item.features : [],
      specs: Array.isArray(item.specs) ? item.specs : [],
      pdfUrl: item.pdf_url || '',
      badge: item.badge,
      image: item.image,
      industries: []
    }));
  } catch (err) {
    console.error('Error al conectar con Supabase para obtener productos:', err);
    return MACHINES;
  }
}
