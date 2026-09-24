import postgres from 'postgres';
import { MACHINES, type Machine } from '../data/machines';

// Obtener DATABASE_URL de variables de entorno (.env)
const databaseUrl = 
  import.meta.env.DATABASE_URL || 
  process.env.DATABASE_URL || 
  '';

let sql: postgres.Sql | null = null;

if (databaseUrl && databaseUrl.startsWith('postgres')) {
  try {
    sql = postgres(databaseUrl, {
      connect_timeout: 4, // 4 segundos máximo para no colgar compilación
      idle_timeout: 10,
      max: 10,
      ssl: false // o 'require' si tienes SSL habilitado
    });
  } catch (err) {
    console.warn('⚠️ No se pudo inicializar la conexión con PostgreSQL en Vultr. Se usarán datos locales fallback.', err);
    sql = null;
  }
}

/**
 * Obtiene todos los equipos desde la base de datos de Vultr.
 * Si la base de datos no está disponible, retorna automáticamente la lista local de MACHINES.
 */
export async function getMachines(): Promise<Machine[]> {
  if (!sql) {
    return MACHINES;
  }

  try {
    const rows = await sql<any[]>`
      SELECT 
        id, 
        name, 
        subtitle, 
        category, 
        technology, 
        speed, 
        resolution, 
        max_width as "maxWidth", 
        description, 
        badge, 
        image, 
        pdf_url as "pdfUrl", 
        web_url as "webUrl", 
        video_url as "videoUrl", 
        features, 
        specs, 
        industries
      FROM machines 
      ORDER BY 
        CASE category 
          WHEN 'impresoras' THEN 1 
          WHEN 'cortadoras' THEN 2 
          WHEN 'especiales' THEN 3 
          ELSE 4 
        END,
        created_at ASC
    `;

    if (!rows || rows.length === 0) {
      console.info('ℹ️ Tabla machines vacía en Vultr. Utilizando datos locales de MACHINES.');
      return MACHINES;
    }

    return rows.map(r => ({
      id: r.id,
      name: r.name,
      subtitle: r.subtitle || '',
      category: r.category,
      technology: r.technology || '',
      speed: r.speed || '',
      resolution: r.resolution || '',
      maxWidth: r.maxWidth || '',
      description: r.description || '',
      badge: r.badge || undefined,
      image: r.image || '',
      pdfUrl: r.pdfUrl || '',
      webUrl: r.webUrl || undefined,
      videoUrl: r.videoUrl || undefined,
      features: Array.isArray(r.features) ? r.features : (typeof r.features === 'string' ? JSON.parse(r.features) : []),
      specs: Array.isArray(r.specs) ? r.specs : (typeof r.specs === 'string' ? JSON.parse(r.specs) : []),
      industries: Array.isArray(r.industries) ? r.industries : (typeof r.industries === 'string' ? JSON.parse(r.industries) : [])
    }));
  } catch (error) {
    console.warn('⚠️ Error al consultar PostgreSQL en Vultr, activando fallback local:', error);
    return MACHINES;
  }
}

/**
 * Obtiene un equipo específico por su identificador slug
 */
export async function getMachineById(id: string): Promise<Machine | undefined> {
  if (!sql) {
    return MACHINES.find(m => m.id === id);
  }

  try {
    const rows = await sql<any[]>`
      SELECT 
        id, 
        name, 
        subtitle, 
        category, 
        technology, 
        speed, 
        resolution, 
        max_width as "maxWidth", 
        description, 
        badge, 
        image, 
        pdf_url as "pdfUrl", 
        web_url as "webUrl", 
        video_url as "videoUrl", 
        features, 
        specs, 
        industries
      FROM machines 
      WHERE id = ${id}
      LIMIT 1
    `;

    if (rows && rows.length > 0) {
      const r = rows[0];
      return {
        id: r.id,
        name: r.name,
        subtitle: r.subtitle || '',
        category: r.category,
        technology: r.technology || '',
        speed: r.speed || '',
        resolution: r.resolution || '',
        maxWidth: r.maxWidth || '',
        description: r.description || '',
        badge: r.badge || undefined,
        image: r.image || '',
        pdfUrl: r.pdfUrl || '',
        webUrl: r.webUrl || undefined,
        videoUrl: r.videoUrl || undefined,
        features: Array.isArray(r.features) ? r.features : (typeof r.features === 'string' ? JSON.parse(r.features) : []),
        specs: Array.isArray(r.specs) ? r.specs : (typeof r.specs === 'string' ? JSON.parse(r.specs) : []),
        industries: Array.isArray(r.industries) ? r.industries : (typeof r.industries === 'string' ? JSON.parse(r.industries) : [])
      };
    }
  } catch (error) {
    console.warn(`⚠️ Error al buscar equipo ${id} en Vultr, usando fallback local.`);
  }

  return MACHINES.find(m => m.id === id);
}

/**
 * Función de utilidad para verificar conexión
 */
export async function testConnection(): Promise<{ success: boolean; message: string }> {
  if (!sql) {
    return { success: false, message: 'DATABASE_URL no está configurada en .env' };
  }
  try {
    const res = await sql`SELECT NOW() as now`;
    return { success: true, message: `Conectado exitosamente a Vultr: ${res[0].now}` };
  } catch (err: any) {
    return { success: false, message: `Error conectando a Vultr: ${err.message}` };
  }
}
