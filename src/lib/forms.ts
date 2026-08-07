import { supabase } from './supabase';

export interface UnifiedRegistrationPayload {
  form_type?: 'cotizacion' | 'showroom_demo' | 'muestras_gratis' | 'calculadora_roi' | 'contacto_general' | 'whatsapp_directo';
  source_page?: string;
  full_name: string;
  company: string;
  email: string;
  phone?: string;
  equipment_interest?: string;
  industry_sector?: string;
  message?: string;
  substrate_type?: string;
  shipping_address?: string;
  roi_run_quantity?: number;
  roi_designs_count?: number;
  roi_prep_minutes?: number;
  roi_total_minutes?: number;
  status?: 'nuevo' | 'contactado' | 'en_cotizacion' | 'demostracion_agendada' | 'muestras_enviadas' | 'cerrado_ganado' | 'descartado';
  internal_notes?: string;
}

// Función unificada para registrar cualquier interacción o formulario de la web en Supabase
export async function submitUnifiedRegistration(payload: UnifiedRegistrationPayload) {
  if (!supabase) {
    console.warn('Supabase no está configurado. Simulando envío exitoso:', payload);
    return { success: true, mock: true };
  }

  try {
    // Insertar en la tabla maestra DPS_MX con record_type = 'registro_form'
    let { data, error } = await supabase
      .from('DPS_MX')
      .insert([{
        record_type: 'registro_form',
        ...payload
      }])
      .select();

    // Fallbacks preventivos por compatibilidad
    if (error) {
      const fb = await supabase
        .from('dps_mx_registros')
        .insert([payload])
        .select();
      
      if (!fb.error) return { success: true, data: fb.data };
      throw error;
    }

    return { success: true, data };
  } catch (err) {
    console.error('Excepción al registrar en Supabase:', err);
    return { success: false, error: err };
  }
}

export interface ContactSubmissionPayload {
  full_name: string;
  company: string;
  email: string;
  phone?: string;
  equipment_interest?: string;
  industry_interest?: string;
  message?: string;
  source_page?: string;
}

export interface SampleRequestPayload {
  full_name: string;
  company: string;
  email: string;
  phone: string;
  substrate_type?: string;
  industry_sector?: string;
  shipping_address?: string;
  notes?: string;
}

export interface RoiSimulationPayload {
  run_quantity: number;
  designs_count: number;
  dps_prep_minutes: number;
  dps_total_minutes: number;
  user_email?: string;
  company_name?: string;
}

// Función para enviar formulario de contacto a Supabase
export async function submitContactForm(payload: ContactSubmissionPayload) {
  return submitUnifiedRegistration({
    form_type: 'cotizacion',
    full_name: payload.full_name,
    company: payload.company,
    email: payload.email,
    phone: payload.phone,
    equipment_interest: payload.equipment_interest,
    industry_sector: payload.industry_interest,
    message: payload.message,
    source_page: payload.source_page || '/contacto'
  });
}

// Función para enviar solicitud de muestras impresas a Supabase
export async function submitSampleRequest(payload: SampleRequestPayload) {
  return submitUnifiedRegistration({
    form_type: 'muestras_gratis',
    full_name: payload.full_name,
    company: payload.company,
    email: payload.email,
    phone: payload.phone,
    substrate_type: payload.substrate_type,
    industry_sector: payload.industry_sector,
    shipping_address: payload.shipping_address,
    message: payload.notes,
    source_page: '/muestras'
  });
}

// Función para guardar simulación de ROI
export async function submitRoiSimulation(payload: RoiSimulationPayload) {
  return submitUnifiedRegistration({
    form_type: 'calculadora_roi',
    full_name: payload.company_name || 'Prospecto Calculadora ROI',
    company: payload.company_name || 'Sin especificar',
    email: payload.user_email || 'calculadora_roi@prospecto.com',
    roi_run_quantity: payload.run_quantity,
    roi_designs_count: payload.designs_count,
    roi_prep_minutes: payload.dps_prep_minutes,
    roi_total_minutes: payload.dps_total_minutes,
    source_page: '/#calculator'
  });
}
