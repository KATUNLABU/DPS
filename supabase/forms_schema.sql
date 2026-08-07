-- ====================================================================
-- KATUN DPS - TABLAS DE FORMULARIOS Y LEADS PARA SUPABASE
-- Ejecuta este script en tu Editor SQL de Supabase (SQL Editor)
-- ====================================================================

-- 1. TABLA PARA SOLICITUDES DE COTIZACIÓN Y CONTACTO DIRECTO
CREATE TABLE IF NOT EXISTS public.contact_submissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name TEXT NOT NULL,
    company TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    equipment_interest TEXT DEFAULT 'Asesoría General',
    industry_interest TEXT DEFAULT 'General',
    message TEXT,
    source_page TEXT DEFAULT 'Contacto',
    status TEXT DEFAULT 'nuevo' CHECK (status IN ('nuevo', 'contactado', 'en_cotizacion', 'demostracion_agendada', 'cerrado')),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. TABLA PARA SOLICITUDES DE MUESTRAS IMPRESAS GRATUITAS
CREATE TABLE IF NOT EXISTS public.sample_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name TEXT NOT NULL,
    company TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    substrate_type TEXT DEFAULT 'Papel Autoadhesivo / BOPP',
    industry_sector TEXT DEFAULT 'Alimentos y Bebidas',
    shipping_address TEXT,
    notes TEXT,
    status TEXT DEFAULT 'pendiente' CHECK (status IN ('pendiente', 'muestras_preparadas', 'enviado', 'entregado')),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. TABLA PARA CÁLCULOS Y SIMULACIONES DE ROI DE CLIENTES
CREATE TABLE IF NOT EXISTS public.roi_simulations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    run_quantity INTEGER NOT NULL,
    designs_count INTEGER NOT NULL,
    dps_prep_minutes INTEGER NOT NULL,
    dps_total_minutes INTEGER NOT NULL,
    user_email TEXT,
    company_name TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ====================================================================
-- POLÍTICAS DE SEGURIDAD (RLS)
-- Permite que los visitantes envíen formularios (INSERT)
-- y que solo los administradores puedan leerlos (SELECT).
-- ====================================================================
ALTER TABLE public.contact_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sample_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.roi_simulations ENABLE ROW LEVEL SECURITY;

-- Políticas de Inserción Pública (Cualquier visitante puede enviar un formulario)
CREATE POLICY "Permitir envío público de contacto" 
    ON public.contact_submissions FOR INSERT WITH CHECK (true);

CREATE POLICY "Permitir envío público de solicitudes de muestras" 
    ON public.sample_requests FOR INSERT WITH CHECK (true);

CREATE POLICY "Permitir envío público de cálculos ROI" 
    ON public.roi_simulations FOR INSERT WITH CHECK (true);

-- Políticas de Lectura (Solo usuarios autenticados / administradores)
CREATE POLICY "Lectura privada de contactos para admins" 
    ON public.contact_submissions FOR SELECT USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

CREATE POLICY "Lectura privada de solicitudes de muestras para admins" 
    ON public.sample_requests FOR SELECT USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

CREATE POLICY "Lectura privada de cálculos ROI para admins" 
    ON public.roi_simulations FOR SELECT USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');
