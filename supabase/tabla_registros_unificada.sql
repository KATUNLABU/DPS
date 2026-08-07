-- ====================================================================
-- KATUN DPS - TABLA UNIFICADA DE FORMULARIOS Y REGISTROS DE LA PÁGINA
-- Copia y ejecuta este script en tu Editor SQL de Supabase (SQL Editor)
-- ====================================================================

-- Creación de la tabla principal para todos los registros y formularios de la web
CREATE TABLE IF NOT EXISTS public.dps_web_registros (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- 1. TIPO DE FORMULARIO / ORIGEN
    form_type TEXT NOT NULL DEFAULT 'contacto' 
        CHECK (form_type IN ('cotizacion', 'showroom_demo', 'muestras_gratis', 'calculadora_roi', 'contacto_general', 'whatsapp_directo')),
    source_page TEXT DEFAULT '/', -- Ejemplo: '/contacto', '/soluciones/arrowjet-aqua-330r', '/industrias'
    
    -- 2. DATOS PERSONALES Y CORPORATIVOS
    full_name TEXT NOT NULL,
    company TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    
    -- 3. INTERÉS DE EQUIPO Y SECTOR INDUSTRIAL
    equipment_interest TEXT DEFAULT 'Asesoría General', -- Ejemplo: 'ArrowJet Aqua 330R', 'LC 350 PM Laser'
    industry_sector TEXT DEFAULT 'General', -- Ejemplo: 'Bebidas', 'Química GHS', 'Comestibles', 'Farmacéutica'
    message TEXT,
    
    -- 4. SOLICITUD DE MUESTRAS FÍSICAS (Si aplica)
    substrate_type TEXT, -- Ejemplo: 'BOPP', 'Papel Autoadhesivo', 'Mylar', 'PET'
    shipping_address TEXT, -- Dirección para envío de muestrario físico
    
    -- 5. CÁLCULOS Y SIMULACIONES DE ROI (Si proviene de la calculadora)
    roi_run_quantity INTEGER, -- Ejemplo: 5000 etiquetas
    roi_designs_count INTEGER, -- Ejemplo: 4 variantes
    roi_prep_minutes INTEGER, -- Minutos de setup
    roi_total_minutes INTEGER, -- Tiempo total estimado
    
    -- 6. GESTIÓN Y ESTADO DEL LEAD (Para el equipo comercial)
    status TEXT DEFAULT 'nuevo' 
        CHECK (status IN ('nuevo', 'contactado', 'en_cotizacion', 'demostracion_agendada', 'muestras_enviadas', 'cerrado_ganado', 'descartado')),
    internal_notes TEXT,
    
    -- 7. TIMESTAMPS
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ====================================================================
-- POLÍTICAS DE SEGURIDAD (RLS)
-- Permite que cualquier visitante envíe datos (INSERT público)
-- y que solo los administradores lean y gestionen los registros (SELECT/UPDATE)
-- ====================================================================
ALTER TABLE public.dps_web_registros ENABLE ROW LEVEL SECURITY;

-- Permitir que los usuarios de la web envíen registros de formularios
CREATE POLICY "Permitir envío público de registros de la web" 
    ON public.dps_web_registros 
    FOR INSERT 
    WITH CHECK (true);

-- Permitir que solo usuarios autenticados o administradores lean los registros
CREATE POLICY "Lectura privada de registros para administradores" 
    ON public.dps_web_registros 
    FOR SELECT 
    USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

-- Permitir actualización de estados solo para administradores
CREATE POLICY "Actualización de registros solo para administradores" 
    ON public.dps_web_registros 
    FOR UPDATE 
    USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

-- Indexación para búsquedas rápidas por email, fecha y estado
CREATE INDEX IF NOT EXISTS idx_dps_registros_email ON public.dps_web_registros(email);
CREATE INDEX IF NOT EXISTS idx_dps_registros_status ON public.dps_web_registros(status);
CREATE INDEX IF NOT EXISTS idx_dps_registros_created_at ON public.dps_web_registros(created_at DESC);
