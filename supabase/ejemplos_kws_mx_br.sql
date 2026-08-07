-- ====================================================================
-- EJEMPLOS DE INSERCIÓN Y MAPEO EN KWS_MX Y KWS_BR
-- Copia y ejecuta estos ejemplos en tu Editor SQL de Supabase cuando desees poblar datos
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. INSERTAR PRODUCTOS / SERVICIOS EN KWS MÉXICO (public.kws_mx)
-- --------------------------------------------------------------------
INSERT INTO public.kws_mx (title, data)
VALUES
(
    'Solución de Impresión Managed Print Services KWS MX',
    '{
        "record_type": "producto",
        "slug": "managed-print-kws",
        "category": "Servicios Impresión",
        "description": "Plataforma de optimización de infraestructura de impresión corporativa para México.",
        "specs": {
            "soporte": "24/7",
            "cobertura": "Nacional México"
        }
    }'::jsonb
),
(
    'Contacto Web KWS México',
    '{
        "record_type": "lead_contacto",
        "full_name": "Carlos Mendoza",
        "company": "Imprenta Grafica MX",
        "email": "carlos@graficamx.com",
        "phone": "+52 55 1234 5678",
        "status": "nuevo"
    }'::jsonb
);

-- --------------------------------------------------------------------
-- 2. INSERTAR PRODUCTOS / SERVICIOS EN KWS BRASIL (public.kws_br)
-- --------------------------------------------------------------------
INSERT INTO public.kws_br (title, data)
VALUES
(
    'Solução de Impressão Managed Print Services KWS BR',
    '{
        "record_type": "produto",
        "slug": "managed-print-kws-br",
        "category": "Serviços de Impressão",
        "description": "Plataforma de otimização de infraestrutura de impressão corporativa para o Brasil.",
        "specs": {
            "suporte": "24/7",
            "cobertura": "Nacional Brasil"
        }
    }'::jsonb
),
(
    'Contato Web KWS Brasil',
    '{
        "record_type": "lead_contato",
        "full_name": "João Silva",
        "company": "Gráfica Brasil LTDA",
        "email": "joao@graficabr.com.br",
        "phone": "+55 11 98765 4321",
        "status": "novo"
    }'::jsonb
);

-- --------------------------------------------------------------------
-- 3. CONSULTAS SQL DE EJEMPLO PARA RECUPERAR DATOS
-- --------------------------------------------------------------------

-- Obtener todos los productos de KWS México:
-- SELECT * FROM public.kws_mx WHERE data->>'record_type' = 'producto';

-- Obtener todos los leads de KWS Brasil:
-- SELECT * FROM public.kws_br WHERE data->>'record_type' = 'lead_contato';
