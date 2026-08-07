import { supabase } from './supabase';

// Interface estándar para registros en las divisiones KWS_MX y KWS_BR
export interface KwsRecordPayload {
  record_type?: 'producto' | 'lead_contacto' | 'catalogo' | 'servicio';
  title: string;
  description?: string;
  category?: string;
  data?: Record<string, any>;
}

// Interface para prospectos / formularios en KWS
export interface KwsLeadPayload {
  full_name: string;
  company: string;
  email: string;
  phone?: string;
  interest?: string;
  message?: string;
  source_site?: 'KWS_MX' | 'KWS_BR';
}

// ====================================================================
// MAPEO Y FUNCIONES PARA KWS MÉXICO (kws_mx)
// ====================================================================

/**
 * Insertar un nuevo producto, servicio o registro en KWS México
 */
export async function insertKwsMxRecord(payload: KwsRecordPayload) {
  if (!supabase) {
    console.warn('[KWS_MX] Supabase no configurado. Simulación:', payload);
    return { success: true, mock: true };
  }

  try {
    const { data, error } = await supabase
      .from('kws_mx')
      .insert([{
        title: payload.title,
        data: {
          record_type: payload.record_type || 'general',
          description: payload.description || '',
          category: payload.category || 'General',
          ...payload.data
        }
      }])
      .select();

    if (error) throw error;
    return { success: true, data };
  } catch (err) {
    console.error('Error al insertar en kws_mx:', err);
    return { success: false, error: err };
  }
}

/**
 * Insertar un lead / contacto en KWS México
 */
export async function insertKwsMxLead(payload: KwsLeadPayload) {
  return insertKwsMxRecord({
    record_type: 'lead_contacto',
    title: `Lead: ${payload.full_name} (${payload.company})`,
    category: 'Formulario Web KWS MX',
    data: {
      ...payload,
      source_site: 'KWS_MX',
      status: 'nuevo',
      created_at: new Date().toISOString()
    }
  });
}

/**
 * Obtener todos los registros de KWS México
 */
export async function getKwsMxRecords(recordType?: string) {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase
      .from('kws_mx')
      .select('*')
      .order('created_at', { ascending: false });

    if (error) throw error;
    if (!recordType) return data;
    return data.filter(item => item.data?.record_type === recordType);
  } catch (err) {
    console.error('Error al consultar kws_mx:', err);
    return [];
  }
}

// ====================================================================
// MAPEO Y FUNCIONES PARA KWS BRASIL (kws_br)
// ====================================================================

/**
 * Insertar un nuevo producto, servicio o registro en KWS Brasil
 */
export async function insertKwsBrRecord(payload: KwsRecordPayload) {
  if (!supabase) {
    console.warn('[KWS_BR] Supabase no configurado. Simulación:', payload);
    return { success: true, mock: true };
  }

  try {
    const { data, error } = await supabase
      .from('kws_br')
      .insert([{
        title: payload.title,
        data: {
          record_type: payload.record_type || 'general',
          description: payload.description || '',
          category: payload.category || 'Geral',
          ...payload.data
        }
      }])
      .select();

    if (error) throw error;
    return { success: true, data };
  } catch (err) {
    console.error('Error al insertar en kws_br:', err);
    return { success: false, error: err };
  }
}

/**
 * Insertar un lead / contacto en KWS Brasil
 */
export async function insertKwsBrLead(payload: KwsLeadPayload) {
  return insertKwsBrRecord({
    record_type: 'lead_contacto',
    title: `Lead BR: ${payload.full_name} (${payload.company})`,
    category: 'Formulário Web KWS BR',
    data: {
      ...payload,
      source_site: 'KWS_BR',
      status: 'novo',
      created_at: new Date().toISOString()
    }
  });
}

/**
 * Obtener todos los registros de KWS Brasil
 */
export async function getKwsBrRecords(recordType?: string) {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase
      .from('kws_br')
      .select('*')
      .order('created_at', { ascending: false });

    if (error) throw error;
    if (!recordType) return data;
    return data.filter(item => item.data?.record_type === recordType);
  } catch (err) {
    console.error('Error al consultar kws_br:', err);
    return [];
  }
}
