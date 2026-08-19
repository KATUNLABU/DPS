import { supabase } from './supabase';

export type UserRole = 'superadmin' | 'admin' | 'editor' | 'author';
export type PostStatus = 'draft' | 'published' | 'archived';

export interface BlogPermissions {
  can_publish: boolean;
  can_delete: boolean;
  can_manage_users: boolean;
  can_edit_all: boolean;
}

export interface BlogProfile {
  id: string;
  email: string;
  full_name: string;
  avatar_url?: string;
  role: UserRole;
  permissions: BlogPermissions;
  is_active: boolean;
  created_at?: string;
  updated_at?: string;
}

export type BlockType = 
  | 'header'
  | 'text'
  | 'quote'
  | 'callout'
  | 'image_text'
  | 'machine_card'
  | 'feature_grid'
  | 'cta'
  | 'gallery';

export interface BlogBlock {
  id: string;
  type: BlockType;
  content: Record<string, any>;
  styles?: {
    bgColor?: string;
    textColor?: string;
    borderColor?: string;
    accentColor?: string;
    padding?: 'none' | 'small' | 'medium' | 'large';
    align?: 'left' | 'center' | 'right';
    borderRadius?: string;
  };
}

export interface BlogPost {
  id?: string;
  slug: string;
  title: string;
  summary: string;
  content_html?: string;
  canvas_blocks: BlogBlock[];
  featured_image: string;
  category: string;
  tags: string[];
  author_id?: string;
  author_name: string;
  author_avatar?: string;
  status: PostStatus;
  reading_time: number;
  views_count?: number;
  seo_title?: string;
  seo_description?: string;
  published_at?: string;
  created_at?: string;
  updated_at?: string;
}

export interface ActivityLog {
  id?: string;
  user_id?: string;
  user_email?: string;
  action: string;
  target_id?: string;
  details?: Record<string, any>;
  ip_address?: string;
  created_at?: string;
}

export const BLOG_CATEGORIES = [
  'Tecnología',
  'Tintas & Sustratos',
  'Automatización',
  'Casos de Éxito',
  'Guías Técnicas',
  'Tendencias del Mercado'
] as const;

// -------------------------------------------------------------
// ARTÍCULO OFICIAL KATUN DPS (Por Aleydis Reyes)
// -------------------------------------------------------------
export const INITIAL_BLOG_POSTS: BlogPost[] = [
  {
    id: 'post_impresion_digital_vs_flexo',
    slug: 'impresion-digital-vs-flexografica-cual-elegir-para-etiquetas',
    title: 'Impresión Digital vs Flexográfica: ¿Cuál Elegir para Etiquetas?',
    summary: 'Dentro de todo proceso productivo, el etiquetado es una etapa crucial para la calidad y percepción del cliente. Exploramos la comparación técnica y estratégica entre la impresión digital y la flexográfica.',
    featured_image: 'https://images.unsplash.com/photo-1563770660941-20978e870e26?auto=format&fit=crop&w=1200&q=80',
    category: 'Tecnología',
    tags: ['Impresión Digital', 'Flexografía', 'Etiquetas Adhesivas', 'Normativas', 'Guía Técnica'],
    author_name: 'Aleydis Reyes',
    author_avatar: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=200&q=80',
    status: 'published',
    reading_time: 5,
    views_count: 0,
    seo_title: 'Impresión Digital vs Flexográfica: ¿Cuál Elegir para Etiquetas? | Katun DPS',
    seo_description: 'Análisis comparativo entre impresión digital y flexografía en volumen, costos iniciales, tiempos de configuración, personalización y sustentabilidad.',
    published_at: new Date().toISOString(),
    canvas_blocks: [
      {
        id: 'blk_intro_header',
        type: 'header',
        content: {
          title: 'El etiquetado como herramienta estratégica y factor de calidad',
          subtitle: 'Análisis comparativo entre impresión digital e impresión flexográfica para la industria de etiquetas',
          badge: 'ARTÍCULO TÉCNICO',
          align: 'left'
        },
        styles: { padding: 'medium' }
      },
      {
        id: 'blk_txt_intro',
        type: 'text',
        content: {
          html: `<p class="text-base sm:text-lg leading-relaxed text-slate-700">Dentro de todo proceso productivo, existe una etapa que tiende a destacar debido a la íntima relación que tiene con la percepción del cliente: <strong>el etiquetado</strong>. Esta fase no sólo es crucial para el atractivo visual del producto, sino también dentro del marco de calidad.</p>
          <p class="mt-4 text-base sm:text-lg leading-relaxed text-slate-700">El etiquetado de un producto, de acuerdo a la industria a la que pertenece, debe cumplir con una serie de normativas que permitan garantizar su carácter; estas regulaciones aseguran (dentro de otros aspectos) que el producto no se vea afectado por ciertas condiciones físicas o ambientales, por ejemplo: altas o bajas temperaturas, exposición a líquidos o entornos desafiantes.</p>
          <p class="mt-4 text-base sm:text-lg leading-relaxed text-slate-700">Actualmente, el etiquetado no es sólo un requisito funcional, sino una <strong>herramienta estratégica que permite diferenciarse en mercados cada vez más competitivos</strong>. No obstante, en comparación con años anteriores, elegir la metodología idónea para crear etiquetas ya no es una decisión sencilla. En el pasado, las alternativas eran escasas y las soluciones evidentes, pero en un mundo que atraviesa cambios constantes y en donde la tecnología permite innovaciones aceleradas, la lista de opciones es cada vez más amplia, haciendo que elecciones entre técnicas de impresión sean cada vez más complejas.</p>
          <p class="mt-4 text-base sm:text-lg leading-relaxed text-slate-700">En este artículo exploraremos de forma general dos metodologías de impresión para etiquetas: <strong>impresión digital e impresión flexográfica</strong>. Principalmente abordaremos algunas características representativas de cada una, así como aspectos comparativos que considerar al momento de tomar una decisión.</p>`
        },
        styles: { padding: 'small' }
      },
      {
        id: 'blk_def_digital',
        type: 'image_text',
        content: {
          title: '¿Qué es la Impresión Digital?',
          description: 'Es un método de impresión que permite emplear archivos digitales (como PDF o aquellos cuyo formato correspondan a archivos de diseño) para transferir imágenes o textos directamente al sustrato empleado.',
          image: 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80',
          imageAlt: 'Impresión digital de etiquetas',
          imagePosition: 'right',
          bullets: [
            'No requiere placas ni moldes para trabajar',
            'Permite eludir las configuraciones mecánicas complejas asociadas',
            'Ideal para tiradas cortas y medianas bajo demanda',
            'Alta flexibilidad para cambios de diseño inmediatos'
          ]
        },
        styles: { bgColor: '#f8fafc', padding: 'medium' }
      },
      {
        id: 'blk_def_flexo',
        type: 'image_text',
        content: {
          title: '¿Qué es la Impresión Flexográfica?',
          description: 'La flexografía se entiende como una metodología de impresión rotativa y tradicional que, a diferencia de la impresión digital, emplea placas o moldes flexibles (normalmente hechos de fotopolímero o caucho) que contienen la imagen requerida construida mediante relieve.',
          image: 'https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?auto=format&fit=crop&w=800&q=80',
          imageAlt: 'Prensa flexográfica rotativa',
          imagePosition: 'left',
          bullets: [
            'Mediante un rodillo anilox se transfiere tinta líquida al relieve de la placa',
            'La placa con tinta gira y presiona contra el material elegido creando el diseño',
            'Si el diseño tiene varios colores, se usan varias placas (una por cada color)',
            'Especialmente ventajosa para tiradas largas y masivas'
          ]
        },
        styles: { bgColor: '#ffffff', padding: 'medium' }
      },
      {
        id: 'blk_table_comparison',
        type: 'text',
        content: {
          html: `<div class="space-y-4 my-8">
            <h3 class="text-xl sm:text-2xl font-bold text-slate-900 font-sans flex items-center gap-2">
              <span class="material-symbols-outlined text-[#00aeef]">compare_arrows</span>
              Comparación entre Metodologías de Impresión
            </h3>
            <div class="overflow-x-auto border border-slate-200 shadow-sm rounded-lg">
              <table class="w-full text-left text-xs sm:text-sm font-sans border-collapse">
                <thead class="bg-slate-900 text-white font-mono uppercase text-[11px]">
                  <tr>
                    <th class="p-3.5 border-b border-slate-800">Aspecto</th>
                    <th class="p-3.5 border-b border-slate-800 bg-[#00aeef]/20 text-[#00aeef]">Impresión Digital</th>
                    <th class="p-3.5 border-b border-slate-800">Flexografía</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-slate-200 text-slate-700 bg-white">
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Volumen</td>
                    <td class="p-3 bg-[#00aeef]/5 font-medium text-sky-800">Ideal para tiradas cortas y medianas.</td>
                    <td class="p-3">Ideal para tiradas largas y masivas.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Costos Iniciales</td>
                    <td class="p-3 bg-[#00aeef]/5"><strong>Bajos</strong>. No requieren de placas ni configuración compleja.</td>
                    <td class="p-3"><strong>Altos</strong>. Existe la necesidad de crear placas y configurar los equipos.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Flexibilidad</td>
                    <td class="p-3 bg-[#00aeef]/5"><strong>Alta</strong>. Pueden hacerse cambios de diseño rápidos y sin costos extra.</td>
                    <td class="p-3"><strong>Baja</strong>. Los cambios requieren nuevas placas.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Calidad de impresión</td>
                    <td class="p-3 bg-[#00aeef]/5"><strong>Excelente</strong>. Alta resolución y precisión de color. Ideal para degradados.</td>
                    <td class="p-3"><strong>Buena</strong>. Menos detalle que la digital.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Velocidad</td>
                    <td class="p-3 bg-[#00aeef]/5">Buena.</td>
                    <td class="p-3">Muy rápida en grandes volúmenes.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Personalización</td>
                    <td class="p-3 bg-[#00aeef]/5"><strong>Perfecta</strong> para personalización y variantes de diseño.</td>
                    <td class="p-3">La personalización es complicada y puede incurrir en costos adicionales.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Sustratos</td>
                    <td class="p-3 bg-[#00aeef]/5">Limitada en ciertos materiales, pero en avance constante.</td>
                    <td class="p-3">Amplia compatibilidad.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Tiempo de configuración</td>
                    <td class="p-3 bg-[#00aeef]/5 text-emerald-700 font-bold">Rápido</td>
                    <td class="p-3 text-amber-700 font-bold">Lento</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Tintas</td>
                    <td class="p-3 bg-[#00aeef]/5">Tintas o tóner de secado rápido.</td>
                    <td class="p-3">Tintas líquidas de secado rápido.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Sustentabilidad</td>
                    <td class="p-3 bg-[#00aeef]/5"><strong>Menor desperdicio</strong> de materiales. Pueden usarse tintas ecológicas.</td>
                    <td class="p-3">Mayor desperdicio durante la configuración. Tintas a base de agua disponibles, pero no siempre utilizadas.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Tiempos de entrega</td>
                    <td class="p-3 bg-[#00aeef]/5"><strong>Rápidas</strong>. Ideales para trabajos urgentes.</td>
                    <td class="p-3">Esperas un poco más largas a causa de la configuración inicial.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Complejidad del diseño</td>
                    <td class="p-3 bg-[#00aeef]/5">Maneja diseños complejos y detallados con facilidad.</td>
                    <td class="p-3">Limitada en diseños muy detallados o con degradados.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Mantenimiento de equipos</td>
                    <td class="p-3 bg-[#00aeef]/5">Se requiere menor mantenimiento.</td>
                    <td class="p-3">Mantenimiento más frecuente y costoso.</td>
                  </tr>
                  <tr class="hover:bg-slate-50/80">
                    <td class="p-3 font-semibold text-slate-900">Espacio requerido</td>
                    <td class="p-3 bg-[#00aeef]/5">Equipos más compactos.</td>
                    <td class="p-3">Máquinas grandes.</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>`
        },
        styles: { padding: 'none' }
      },
      {
        id: 'blk_callout_conclusion',
        type: 'callout',
        content: {
          title: 'Conclusión',
          text: 'Cada metodología de impresión ya sea digital o flexográfica, tiene sus propias ventajas y desventajas. Es importante el poder visualizarlas como técnicas complementarias y no considerarlas rivales. La elección entre una y otra dependerá de las necesidades específicas de cada industria o inclusive de cada proyecto. Integrar ambas estrategias, podría ser el combo ideal para maximizar la eficiencia y adaptarse a un mercado en constante evolución.',
          icon: 'lightbulb',
          variant: 'primary'
        },
        styles: { bgColor: '#f8fafc', borderColor: '#00aeef' }
      },
      {
        id: 'blk_sources',
        type: 'text',
        content: {
          html: `<div class="p-6 bg-slate-50 border border-slate-200 rounded-lg text-xs text-slate-600 space-y-3">
            <h4 class="font-bold text-slate-900 uppercase text-[11px] font-mono">Fuentes Consultadas</h4>
            <ul class="list-disc pl-5 space-y-1.5 font-mono">
              <li><a href="https://www.esagraf.com/caracteristicas-impresion-flexografica/" target="_blank" rel="noopener" class="text-[#00aeef] hover:underline">«Características de la Impresión Flexográfica.» ESAGRAF.</a></li>
              <li><a href="https://www.proprintweb.com/blog/la-impresion-flexografica" target="_blank" rel="noopener" class="text-[#00aeef] hover:underline">«La Impresión Flexográfica: Todo lo que Necesitas Saber.» ProPrintWeb.</a></li>
              <li><a href="https://mammothpackaging.com/flexo-vs-digital-whats-the-difference/" target="_blank" rel="noopener" class="text-[#00aeef] hover:underline">«Flexo vs. Digital: ¿Cuál es la Diferencia?» Mammoth Packaging.</a></li>
              <li><a href="https://www.ketegroup.com/es/impresion-digital-vs-flexografica/" target="_blank" rel="noopener" class="text-[#00aeef] hover:underline">«Impresión Digital vs. Flexográfica: ¿Cuál Elegir?» KETE Group.</a></li>
            </ul>
          </div>`
        },
        styles: { padding: 'none' }
      }
    ]
  }
];

// -------------------------------------------------------------
// SEGURIDAD & SANITIZACIÓN (XSS & VALIDACIÓN)
// -------------------------------------------------------------
export function sanitizeHtmlText(dirty: string): string {
  if (!dirty) return '';
  // Sanitización estricta de tags no deseados y atributos peligrosos (javascript:, onload, etc)
  return dirty
    .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
    .replace(/<iframe\b[^<]*(?:(?!<\/iframe>)<[^<]*)*<\/iframe>/gi, '')
    .replace(/on\w+="[^"]*"/gi, '')
    .replace(/on\w+='[^']*'/gi, '')
    .replace(/javascript:[^"']*/gi, '');
}

export function slugify(text: string): string {
  return text
    .toString()
    .toLowerCase()
    .trim()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '') // Quitar acentos
    .replace(/[^a-z0-9 -]/g, '')     // Quitar caracteres no alfanuméricos
    .replace(/\s+/g, '-')            // Reemplazar espacios por guiones
    .replace(/-+/g, '-');            // Evitar múltiples guiones juntos
}

// -------------------------------------------------------------
// CONSULTAS PÚBLICAS Y MÉTODOS DE SERVICIO
// -------------------------------------------------------------

export async function getPublishedBlogPosts(category?: string, tag?: string): Promise<BlogPost[]> {
  let list = [...INITIAL_BLOG_POSTS];

  try {
    if (supabase) {
      let query = supabase
        .from('blog_posts')
        .select('*')
        .eq('status', 'published')
        .order('published_at', { ascending: false });

      if (category && category !== 'Todos') {
        query = query.eq('category', category);
      }

      if (tag) {
        query = query.contains('tags', [tag]);
      }

      const { data, error } = await query;
      if (!error && data && data.length > 0) {
        // Filtrar posts de prueba legacy (Roberto González)
        const validSupabasePosts = (data as BlogPost[]).filter(
          p => p.slug !== 'revolucion-troquelado-laser-memjet-duraflex-2026' &&
               p.author_name !== 'Roberto González'
        );
        const combined = [...validSupabasePosts];
        list.forEach(localPost => {
          if (!combined.some(p => p.slug === localPost.slug)) {
            combined.push(localPost);
          }
        });
        list = combined;
      }
    }
  } catch (err) {
    console.warn('Error conectando a Supabase para posts, usando fallback local:', err);
  }

  // Filtrar cualquier post de prueba legacy
  list = list.filter(
    p => p.slug !== 'revolucion-troquelado-laser-memjet-duraflex-2026' &&
         p.author_name !== 'Roberto González'
  );

  if (category && category !== 'Todos') {
    list = list.filter(p => p.category.toLowerCase() === category.toLowerCase());
  }
  if (tag) {
    list = list.filter(p => p.tags.some(t => t.toLowerCase() === tag.toLowerCase()));
  }
  return list;
}

export async function getBlogPostBySlug(slug: string): Promise<BlogPost | null> {
  if (slug === 'revolucion-troquelado-laser-memjet-duraflex-2026') return null;

  try {
    if (supabase) {
      const { data, error } = await supabase
        .from('blog_posts')
        .select('*')
        .eq('slug', slug)
        .single();

      if (!error && data && data.author_name !== 'Roberto González') {
        return data as BlogPost;
      }
    }
  } catch (err) {
    console.warn('Error obteniendo post por slug de Supabase:', err);
  }

  // Buscar en fallback
  const found = INITIAL_BLOG_POSTS.find(p => p.slug === slug);
  return found || null;
}

export async function getAllBlogPostsAdmin(): Promise<BlogPost[]> {
  try {
    if (supabase) {
      const { data, error } = await supabase
        .from('blog_posts')
        .select('*')
        .neq('slug', 'revolucion-troquelado-laser-memjet-duraflex-2026')
        .neq('author_name', 'Roberto González')
        .order('created_at', { ascending: false });

      if (!error && data) {
        return data as BlogPost[];
      }
    }
  } catch (err) {
    console.warn('Error cargando posts para admin:', err);
  }

  // Local storage o fallback
  return INITIAL_BLOG_POSTS;
}

export async function incrementPostViews(slug: string): Promise<void> {
  try {
    if (supabase) {
      await supabase.rpc('increment_post_views', { target_slug: slug });
    }
  } catch {
    // Silencioso
  }
}

// -------------------------------------------------------------
// GESTIÓN DE USUARIOS Y ROLES (RBAC)
// -------------------------------------------------------------

export async function getBlogProfiles(): Promise<BlogProfile[]> {
  try {
    if (supabase) {
      const { data, error } = await supabase
        .from('blog_profiles')
        .select('*')
        .order('created_at', { ascending: false });

      if (!error && data && data.length > 0) {
        return data as BlogProfile[];
      }
    }
  } catch (err) {
    console.warn('Error obteniendo perfiles de Supabase:', err);
  }

  // Fallback demo profiles
  return [
    {
      id: 'usr_superadmin',
      email: 'admin@katundps.com',
      full_name: 'Administrador Principal Katun',
      role: 'superadmin',
      permissions: {
        can_publish: true,
        can_delete: true,
        can_manage_users: true,
        can_edit_all: true
      },
      is_active: true,
      created_at: new Date().toISOString()
    },
    {
      id: 'usr_editor',
      email: 'editor@katundps.com',
      full_name: 'Editor de Contenidos DPS',
      role: 'editor',
      permissions: {
        can_publish: true,
        can_delete: false,
        can_manage_users: false,
        can_edit_all: true
      },
      is_active: true,
      created_at: new Date().toISOString()
    },
    {
      id: 'usr_author',
      email: 'autor@katundps.com',
      full_name: 'Ing. Roberto Katun DPS',
      role: 'author',
      permissions: {
        can_publish: false,
        can_delete: false,
        can_manage_users: false,
        can_edit_all: false
      },
      is_active: true,
      created_at: new Date().toISOString()
    }
  ];
}

export async function logActivity(action: string, targetId?: string, details?: Record<string, any>): Promise<void> {
  try {
    if (supabase) {
      const { data: { user } } = await supabase.auth.getUser();
      await supabase.from('blog_activity_logs').insert({
        user_id: user?.id || null,
        user_email: user?.email || 'anonimo@dps.com',
        action,
        target_id: targetId || null,
        details: details || {}
      });
    }
  } catch (err) {
    console.warn('Error registrando log de actividad:', err);
  }
}
