-- ====================================================================
-- KATUN DPS - ESQUEMA INTEGRAL DE BASE DE DATOS PARA VPS (POSTGRESQL 16)
-- ====================================================================
-- Este archivo inicializa automáticamente todas las tablas del proyecto:
-- 1. machines: Catálogo oficial de los 14 equipos (con WebP y datos actualizados)
-- 2. contact_submissions, sample_requests, roi_simulations: Leads y formularios
-- 3. blog_profiles, blog_posts, blog_activity_logs: CMS, roles y publicaciones
--
-- Uso automático con Docker:
--   docker compose -f vultr-docker-compose.yml up -d
-- ====================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- --------------------------------------------------------------------
-- 1. TABLA: machines (Catálogo de Equipos)
-- --------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS machines (
    id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    subtitle TEXT NOT NULL,
    category VARCHAR(50) NOT NULL CHECK (category IN ('impresoras', 'cortadoras', 'especiales')),
    technology VARCHAR(150),
    speed VARCHAR(100),
    resolution VARCHAR(100),
    max_width VARCHAR(100),
    description TEXT,
    badge VARCHAR(50),
    image TEXT,
    gallery JSONB DEFAULT '[]'::jsonb,
    pdf_url TEXT,
    web_url TEXT,
    video_url TEXT,
    features JSONB DEFAULT '[]'::jsonb,
    specs JSONB DEFAULT '[]'::jsonb,
    industries JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_machines_category ON machines(category);

-- Insertar los 14 equipos
INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'vipcolor-vp610-vp660', 'VIP Color VP660 / VP610', 'Impressora digital de rótulos por injeção direta de tinta, acabamento brilhante e resistente à água', 'impresoras', 'Memjet Versapass®',
    'Até 18 m/min (305 mm/s)', '1600 x 1600 dpi', '20 cm (8")', 'Impressora digital de mesa de alto desempenho para rótulos e etiquetas coloridas sob demanda. Cabeçote com 70.000 bicos de microinjeção, ideal para tiragens curtas e médias sem custo de pré-impressão ou clichês.', 'MAIS POPULAR',
    '/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-roll-to-roll-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-roll-to-roll-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-frontal.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-perspectiva.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-web-card.webp"]'::jsonb, '/maquinas/02-katun-dps-impresora-vp-610-660-web_.pdf', 'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/impresora-vip-color-uvp-660/', 'https://www.youtube.com/embed/QFKxWpR_XJQ',
    '["Cabeçote industrial com 70.000 bicos de microinjeção","Imprime até 2.400 etiquetas (4x6\") em apenas 10 minutos","Cartuchos individuais CMYK de alta capacidade (250 ml)","Design de mesa compacto para laboratório ou linha de envase","Zero tempo de preparação comparado à flexografia tradicional"]'::jsonb, '[{"label":"TECNOLOGIA","value":"Memjet Versapass Single Pass"},{"label":"VELOCIDADE ALTA RES.","value":"9 m/min a 1600x1600 dpi"},{"label":"LARGURA DE IMPRESSÃO","value":"20 cm (8\")"},{"label":"CAPACIDADE TINTA","value":"Tanques individuais de 250ml CMYK"}]'::jsonb, '["Alimentos Refrigerados","Saúde e Nutrição","Cuidados Pessoais","Cosméticos"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'aquajet-330-hybrid-pro-m', 'ArrowJet Aqua 330R - Hybrid PRO M', 'Prensa digital híbrida para rótulos de alta resolução e embalagens flexíveis com primer e verniz', 'impresoras', 'Memjet DuraFlex® Híbrida',
    'Até 21 m/min', '1600 x 1600 dpi', '32,4 cm (12.75")', 'O sistema ''tudo-em-um'' definitivo para conversão de rótulos. Imprime digitalmente em altíssima definição, aplica laminação a frio, corta em contorno e remove a matriz de refile em uma única passagem contínua.', 'HÍBRIDA PRO',
    '/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/02_ArrowJet_Aqua_330R_Hybrid_PRO_M/arrowjet-aqua-330r-hybrid-pro-m-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/02_ArrowJet_Aqua_330R_Hybrid_PRO_M/arrowjet-aqua-330r-hybrid-pro-m-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/02_ArrowJet_Aqua_330R_Hybrid_PRO_M/arrowjet-aqua-330r-hybrid-pro-m-angulo.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/02_ArrowJet_Aqua_330R_Hybrid_PRO_M/arrowjet-aqua-330r-hybrid-pro-m-vista-catalogo.webp"]'::jsonb, '/maquinas/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_.pdf', 'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/arrowjet-aqua-330r-hybrid-pro-m/', 'https://www.youtube.com/embed/D_fF7Vav0O4',
    '["Processo completo: da bobina virgem ao rótulo acabado e rebobinado","Módulo de laminação a frio e despalilhador sincronizado","Sistema de corte de contorno de alta precisão integrado","Rebobinador de matriz residual incorporado"]'::jsonb, '[{"label":"IMPRESSÃO","value":"Digital CMYK Memjet DuraFlex"},{"label":"LAMINAÇÃO","value":"Laminador a frio automático integrado"},{"label":"LARGURA MÁXIMA","value":"32,4 cm (12.75\")"},{"label":"VELOCIDADE","value":"Até 21 m/min"}]'::jsonb, '["Vinhos e Destilados","Farmacêutica","Químicos GHS","Rótulos Premium"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'katun-lt330', 'Katun DPS LT330', 'Impressora digital de rótulos CMYK + Branco em bobina contínua', 'impresoras', 'Digital LED HD (Toner Seco)',
    '9,14 m/min', '1200 x 1200 dpi', '32 cm (12.6")', 'Solução versátil e econômica com tecnologia toner seco LED HD para impressão CMYK + Branco sobre materiais transparentes, metalizados, papéis texturizados e filmes sintéticos sem necessidade de pré-tratamento (primer).', 'CMYK + BRANCO',
    '/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-perspectiva-3d.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-estacion-cmykw.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-vista-lateral.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-card-frontal.webp"]'::jsonb, '/maquinas/03-katun-dps-impresora-lt330-web-.pdf', 'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/impresora-de-etiquetas-lt330-cmyk-blanco/', 'https://www.youtube.com/embed/xmQ32C1a-yk',
    '["Fusão seca LED de alta definição com excelente ancoragem","Branco de alta opacidade para fundos em materiais transparentes e metálicos","Operação intuitiva sem necessidade de técnico especializado","Registro micrométrico em rótulos multicoloridos"]'::jsonb, '[{"label":"CONFIGURAÇÃO","value":"CMYK + Branco de alta opacidade"},{"label":"RESOLUÇÃO","value":"1200 x 1200 dpi"},{"label":"LARGURA DA BANDA","value":"330 mm (13\")"},{"label":"VELOCIDADE","value":"9,14 m/min"}]'::jsonb, '["Rótulos Industriais","Sinalização","Bebidas e Cervejarias","Pequenas e Médias Tiragens"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'katun-klt3', 'Katun DPS KLT3', 'Impressora industrial de rótulos rolo a rolo CMYK de alta produtividade', 'impresoras', 'Inkjet Piezoelétrico UV / Água',
    'Até 30 m/min', '1200 x 1200 dpi', '33 cm (13")', 'Prensa digital industrial robusta projetada para regime contínuo 24/7. Cabeçotes piezoelétricos industriais com cura UV LED de baixa temperatura, oferecendo máxima vivacidade de cor e durabilidade extrema aos elementos.', 'INDÚSTRIA 24/7',
    '/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-hd.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-modulo-impresion.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-vista-operativa.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-card.webp"]'::jsonb, '/maquinas/05-katun-dps-impresora-klt3_web.pdf', 'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/klt3-impresora-de-etiquetas/', 'https://www.youtube.com/embed/NMrxJahHZ-A',
    '["Cabeçotes piezoelétricos industriais com tecnologia de gota variável","Cura UV LED fria compatível com filmes termo-sensíveis","Excelente resistência química e à radiação solar","Construção em aço usinado de padrão industrial para operação contínua"]'::jsonb, '[{"label":"CABEÇOTES","value":"Piezoelétricos industriais"},{"label":"CURA","value":"UV LED Cold-Cure"},{"label":"LARGURA DA BANDA","value":"330 mm"},{"label":"VELOCIDADE","value":"Até 30 m/min"}]'::jsonb, '["Químicos e Lubrificantes","Cosméticos","Decoração","Vinhos e Destilados"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'arrowjet-aqua-330r', 'ArrowJet Aqua 330R', 'Impressora digital de injeção de tinta pigmentada de alta velocidade para rótulos e embalagens flexíveis', 'impresoras', 'Memjet DuraFlex®',
    'Até 21 m/min (69 ft/min)', '1600 x 1600 dpi', '32,4 cm (12.75")', 'Prensa digital líder para bobinas de rótulos e embalagens flexíveis pouch/Mylar. Equipada com cabeçote Memjet DuraFlex de alta durabilidade e secador infravermelho próximo (NIR) instantâneo para tintas pigmentadas à base de água resistentes à luz e água.', 'MÁXIMA VELOCIDADE',
    '/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-principal-2025.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-principal-2025.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-render-hd.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-frontal.webp","/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-perspectiva.webp"]'::jsonb, '/maquinas/01-katun-dps-impresora-aqua-330r-web-2_.pdf', 'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/arrowjet-aqua-330r/', 'https://www.youtube.com/embed/6CFHlWSeYQU',
    '["Cabeçote único CMYK Memjet DuraFlex com vida útil prolongada","Secagem ultra-rápida por Infravermelho Próximo (NIR)","Tintas pigmentadas base água resistentes à umidade, atrito e luz UV","Homologada para rótulos alimentícios e químicos conforme normas internacionais","Tanques industriais de tinta de 2L a 10L para produção ininterrupta"]'::jsonb, '[{"label":"TIPO IMPRESSÃO","value":"CMYK em cabeçote único Single Pass"},{"label":"RESOLUÇÃO","value":"1600x1600 dpi ou 1600x954 dpi"},{"label":"LARGURA MÁXIMA ROLO","value":"38,1 cm (15\")"},{"label":"LARGURA ÚTIL IMPRESSÃO","value":"32,4 cm (12.75\")"},{"label":"DIÂMETRO DO ROLO","value":"50 cm (19.7\")"},{"label":"SUBSTRATOS","value":"Papel couché/brilhante, PP, PET, PVC, BOPP, Mylar"}]'::jsonb, '["Alimentos e Bebidas","Químicos e Industriais","Farmacêutica","Limpeza e Higiene"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'kf30x', 'Cortadora KF30X', 'Cortadora digital de rótulos rolo a rolo com 1 lâmina tangencial de alta precisão', 'cortadoras', 'Lâmina Tangencial Digital (1 Lâmina)',
    'Cerca de 1 m/min', '< ±0.08 mm (Câmera CCD)', '33 cm (12.9")', 'Cortadora e finalizadora digital rolo a rolo compacta e precisa. Equipada com 1 lâmina tangencial digital de altíssima definição (sem custo de matrizes mecânicas), câmera CCD para alinhamento automático de marcas de registro, laminação a frio e rebobinamento de matriz residual.', '1 LÂMINA TANGENCIAL',
    '/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-principal-hq.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-principal-hq.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-frontal.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-cabezal-tangencial.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-rebobinado-merma.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-panel-control.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-card.webp"]'::jsonb, '/maquinas/cortadora-kf30x-brochure-web.pdf', 'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/cortadora-etiquetas-kf30x/', NULL,
    '["Sistema de 1 lâmina tangencial digital de altíssima precisão de corte","Velocidade de trabalho próxima a 1 m/min para máxima definição de bordas e curvas complexas","Câmera CCD para reconhecimento automático de marcas de corte","Laminador a frio e removedor automático de matriz de refile","Estrutura robusta antivibração com tela touchscreen de 7 polegadas"]'::jsonb, '[{"label":"SISTEMA DE CORTE","value":"1 lâmina tangencial digital de alta precisão"},{"label":"VELOCIDADE REAL","value":"Cerca de 1 m/min (15 cm/min passo a passo)"},{"label":"ÁREA MÁX. CORTE","value":"33 cm x 33 cm (12.9\" x 12.9\")"},{"label":"DIÂMETRO MÁX. ROLO","value":"35,5 cm (14\")"},{"label":"SENSOR DE REGISTRO","value":"Câmera CCD de alta definição"}]'::jsonb, '["Rótulos Adesivos","Rotulagem Sob Demanda","Pequenas e Médias Tiragens"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'arrow-ezcut-vr-240x', 'Arrow EzCut VR 240 X', 'Cortadora digital de mesa para rótulos rolo a rolo', 'cortadoras', 'Plotter de Lâmina Drag Knife',
    'Até 6 m/min', '±0.1 mm', '24 cm (9.4")', 'Solução de acabamento compacta e acessível de mesa para gráficas rápidas, convertedores e fabricantes que desejam automatizar o corte de rótulos em bobina com laminação integrada.', 'COMPACTA DE MESA',
    '/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-vista-general.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-modulo-corte-dragknife.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-traccion-bobina.webp"]'::jsonb, '/maquinas/arrow-ezcut-vr-240xbrochure-web_compressed.pdf', 'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/vr-240-x-cortadora-rollo-a-rollo/', NULL,
    '["Design de mesa ultracompacto para qualquer ambiente produtivo","Laminação a frio e rebobinamento de desperdício em um só passo","Importação direta de arquivos vetoriais DXF / PLT","Operação silenciosa com manutenção simplificada"]'::jsonb, '[{"label":"LARGURA DO ROLO","value":"240 mm (9.4\")"},{"label":"VELOCIDADE CORTE","value":"Até 6 m/min"},{"label":"TIPO DE LÂMINA","value":"Drag Knife orientada por sensor óptico"}]'::jsonb, '["Pequenas Empresas","Marcas Próprias","Laboratórios de Teste"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'arrow-ezcut-330rx', 'Arrow EzCut 330 RX', 'Troqueladora digital de rótulos rolo a rolo com facas pneumáticas contínuas', 'cortadoras', 'Lâminas Pneumáticas Digitais',
    'Até 18 m/min', 'Precisão 0.05 mm', '33 cm (13")', 'Estação de acabamento digital avançada que integra laminação a frio, corte contínuo de contorno sem matrizes físicas através de lâminas com regulagem pneumática, refile longitudinal de bordas e rebobinamento duplo.', 'MULTI-LÂMINAS',
    '/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-principal-2025.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-principal-2025.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-angulo.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-perspectiva.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-sensor-posicionamiento.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-slitting.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-desbobinador.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-extraccion-merma.webp"]'::jsonb, '/maquinas/arrow-ezcut-330rx-brochure-web_compressed.pdf', 'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/arrow-ezcut-330-rx/', NULL,
    '["Corte contínuo a partir de arquivo vetorial digital sem necessidade de facas de corte mecânicas","Cabeçotes de corte com ajuste pneumático digital de pressão","Laminação a frio de proteção e transparência integrada","Extração e rebobinamento automático do esqueleto de rótulo excedente"]'::jsonb, '[{"label":"LARGURA DA BANDA","value":"330 mm (13\")"},{"label":"SISTEMA DE CORTE","value":"Lâminas de corte contínuo pneumáticas"},{"label":"VELOCIDADE MÁXIMA","value":"Até 18 m/min"}]'::jsonb, '["Rótulos sob Demanda","Cervejarias Artesanais","Cosméticos"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'arrow-ezcut-350r', 'Arrow EzCut 350R', 'Cortadora digital de rótulos rolo a rolo de lâminas múltiplas de alta produtividade', 'cortadoras', 'Corte Digital Multi-Lâmina (4 a 8 Lâminas)',
    'Até 9 m/min', 'Precisão < ±0.1 mm', '33 cm (13")', 'Cortadora digital de etiquetas e rótulos de lâminas múltiplas de rolo a rolo. Sistema completo com 4 a 8 cabeçotes de corte que operam simultaneamente com ajuste automático de distância entre facas, remoção de matriz, corte longitudinal até 100 m/min e computador integrado.', 'MULTI-LÂMINAS (4-8)',
    '/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/04_Arrow_EzCut_350R/arrow-ezcut-350r-principal-hd.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/04_Arrow_EzCut_350R/arrow-ezcut-350r-principal-hd.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/04_Arrow_EzCut_350R/arrow-ezcut-350r-equipo-real.webp"]'::jsonb, '/maquinas/arrow-ezcut-350R-brochure-web-_compressed.pdf', 'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/vr-230-cortadora-rollo-a-rollo-dps/', NULL,
    '["Sistema de corte simultâneo com 4 a 8 cabeçotes de lâminas de corte","Ajuste automático motorizado da distância entre todos os cabeçotes","Leitor óptico de alinhamento com câmera CCD de alta velocidade","Módulo de laminação a frio e rebobinador de matriz residual integrado","Corte longitudinal de tiras (slitting) em alta velocidade até 100 m/min"]'::jsonb, '[{"label":"CABEÇOTES DE CORTE","value":"4 a 8 cabeçotes com facas de alta precisão"},{"label":"VELOCIDADE DE CORTE","value":"9 m/min (29.5 pés/min)"},{"label":"LARGURA MÁXIMA","value":"33 cm (13\") - Comprimento até 80 cm"},{"label":"CORTE LONGITUDINAL","value":"Até 100 m/min com facas rotativas"},{"label":"SISTEMA OPERACIONAL","value":"Computador industrial integrado com tela LCD"}]'::jsonb, '["Farmacêutica","Rótulos de Segurança","Eletrônicos","Cosméticos"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'aries-35pl', 'Aries 35 PL', 'Finalizadora de rótulos semirrotativa servo-acionada de alta capacidade', 'cortadoras', 'Troquelagem Semirrotativa Servo',
    'Até 60 m/min', 'Tolerância ±0.1 mm', '35 cm (13.7")', 'Finalizadora semirrotativa de alta performance para convertedores industriais. Integra troquelagem magnética semirrotativa servomotorizada, alinhamento por marca de registro, laminação, despalilhamento e corte longitudinal.', 'SEMIRROTATIVA',
    '/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-principal-hd.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-principal-hd.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-troquel-magnetico.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-laminacion-frio.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-control-tension.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-modulo-barniz.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-panel-ajustes.webp"]'::jsonb, '/maquinas/aries-35plbrochure-web_compressed.pdf', 'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/aries-finalizadoras-de-etiquetas-semirotativas/', NULL,
    '["Velocidade de até 60 m/min em modo semirrotativo sincronizado","Alinhamento óptico por leitura contínua de marca de registro","Unidade de laminação de proteção e despalilhador de matriz","Lâminas longitudinais para divisão de pistas (slitting) em múltiplos rolos"]'::jsonb, '[{"label":"LARGURA DO SUBSTRATO","value":"350 mm (13.7\")"},{"label":"VELOCIDADE MÁXIMA","value":"60 m/min"},{"label":"ACIONAMENTO","value":"Servomotores digitais de alta resposta"}]'::jsonb, '["Convertedores de Rótulos","Gráficas Comerciais","Indústria de Bebidas"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'taurus-pl-series', 'Taurus 35 PL Plus Láser CO2', 'Finalizadora de rótulos com corte a laser CO2, laminação e mesa de vácuo', 'cortadoras', 'Corte a Laser CO2 Galvanométrico Industrial',
    'Até 70 m/min', 'Submicrônica (Ponto laser 250 - 350 µm)', '35 cm (13.7")', 'Finalizadora digital industrial de rótulos e etiquetas com corte a laser CO2 de alta potência (150W a 350W). Elimina totalmente matrizes e clichês mecânicos, permitindo trocas instantâneas de formato, micropolimento de bordas, gravação e meio-corte a até 70 m/min.', 'LASER CO2 70 M/MIN',
    '/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-plus-laser-co2-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-plus-laser-co2-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-plus-laser-co2-modulo-corte.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-cuchillas-rotativas.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-slitting.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-guia-bobina.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-extraccion-merma.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-lector-datamatrix.webp"]'::jsonb, '/maquinas/taurus-25-pl-35pl-35pl-plus-brochure-web_compressed.pdf', 'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/taurus-cortadoras-laser-para-etiquetas-con-laminado/', NULL,
    '["Fonte de laser CO2 selada de alta frequência com cabeçote galvanométrico","Velocidade de corte contínuo a laser de até 70 m/min","Mesa de sucção por vácuo multizona para perfeito assentamento da fita","Corte de contornos complexos, microperfuração, vinco e meio-corte óptico","Módulo de laminação e extração de esqueleto residual incorporados"]'::jsonb, '[{"label":"FONTE LASER","value":"Laser CO2 RF de 150W a 350W (Sem lâminas mecânicas)"},{"label":"VELOCIDADE MÁXIMA","value":"Até 70 m/min"},{"label":"LARGURA DE TRABALHO","value":"Taurus 25 PL (250mm) / 35 PL Plus (350mm)"},{"label":"MESA DE VÁCUO","value":"Platen servo-controlado de sucção contínua"},{"label":"TIPOS DE CORTE","value":"Meio-corte, corte total, perfuração e gravação"}]'::jsonb, '["Convertedores Industriais","Farmacêutica de Grande Escala","Indústria Automotiva","Cosméticos High-End"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'gemini-40', 'Gemini 40', 'Finalizadora de corte e acabamento de rótulos e embalagens por folha solta (Formato Máx. B3)', 'cortadoras', 'Corte Digital por Folha com Plotter Graphtec',
    'Até 12 m/min', 'Câmera CCD Óptica', '35 cm x 50 cm (Formato B3)', 'Equipamento compacto de mesa desenvolvido com tecnologia de plotter Graphtec para cortar contornos de rótulos adesivos, embalagens, cartões e impressos digitais em folhas avulsas. Conta com bandeja de alimentação automática estilo rampa para até 150 folhas e software Gemini Cutting Manager.', 'CORTE EM FOLHA (B3)',
    '/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-cortadora-pliego-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-cortadora-pliego-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-perspectiva-operacion.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-real-hd.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-card.webp"]'::jsonb, '/maquinas/brochue-cortadora-de-etiquetas-gemini-40-.pdf', 'https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/dpr-gemini-40-60-corte-yacabado-de-etiquetas-por-pliego/', NULL,
    '["Plotter Graphtec de precisão integrado para corte de folhas adesivas e cartão","Bandeja de alimentação automática em rampa para até 150 folhas","Câmera CCD integrada para leitura automática de marcas de registro em segundos","Corte total, meio-corte de etiquetas e vinco para dobras de embalagens","Software intuitivo Gemini Cutting Manager compatível com arquivos vetoriais"]'::jsonb, '[{"label":"FORMATO MÁX. FOLHA","value":"B3 (353 mm x 500 mm / 19.69\" x 13.89\")"},{"label":"GRAMATURA SUPORTADA","value":"Cartão 200 a 350 g/m² e folhas adesivas desde 170 g/m²"},{"label":"ALIMENTADOR","value":"Automático com capacidade para 150 folhas"},{"label":"TECNOLOGIA PLOTTER","value":"Graphtec industrial de lâmina orientada"}]'::jsonb, '["Gráficas Digitais Sheetfed","Design e Prototipagem","Embalagens Promocionais"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'lc-350-pm', 'Cortadora de Rótulos por Folha LC 350 PM', 'Cortadora digital por folha com alimentação automática e 2 lâminas (corte e vinco)', 'cortadoras', 'Corte Digital por Folha com Dupla Lâmina (Corte + Vinco)',
    'Até 12 cm/s (1,2 m/s)', 'Menor que ±0.05 mm (Câmera CCD HD)', '35 cm (Largura Máx. da Folha)', 'Cortadora digital de rótulos e embalagens por folha solta com alimentação automática contínua e motor de passo com encoder. Equipada com 1 lâmina para corte e 1 lâmina para vinco, câmera CCD HD para leitura de marcas de registro e QR code, operando com precisão nanométrica em papéis e sintéticos.', 'CORTE EM FOLHA (2 LÂMINAS)',
    '/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-angulo.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-lateral.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-alimentador.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-cabezal-doble-herramienta.webp","/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-card.webp"]'::jsonb, '/maquinas/cortadora-de-etiquetas-lc-350-pm-katun-dps_nuevo-web.pdf', 'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/lc-350-pm-cortadora-de-etiquetas-por-pliego/', NULL,
    '["Sistema de dupla ferramenta: 1 lâmina para corte contorno e 1 lâmina para vinco de embalagens","Alimentação automática de folhas com rolos de tração de longa durabilidade","Câmera CCD HD para alinhamento e leitura de código QR de troca automática de trabalho","Display touchscreen LCD colorido de 4.3 polegadas com interface intuitiva","Conectividade versátil via USB, Pen Drive, Wi-Fi e rede Ethernet"]'::jsonb, '[{"label":"LÂMINAS DE TRABALHO","value":"1 lâmina para corte e 1 lâmina para vinco (dupla ferramenta)"},{"label":"LARGURA MÁX. FOLHA","value":"35 cm (largura máxima de corte útil 32 cm)"},{"label":"VELOCIDADE MÁXIMA","value":"12 cm/s (1,2 m/s)"},{"label":"ESPESSURA SUPORTADA","value":"80g a 400g / até 1 mm de espessura"},{"label":"PRESSÃO DA LÂMINA","value":"Regulável de 50g a 800g"},{"label":"LEITURA DE REGISTRO","value":"Câmera HD para marcas em L, circulares ou QR Code"}]'::jsonb, '["Gráficas Digitais","Embalagens Rápidas","Rótulos para Cosméticos e Alimentos","Etiquetas por Folha"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO machines (
    id, name, subtitle, category, technology, speed, resolution,
    max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
    features, specs, industries
) VALUES (
    'contador-automatico', 'Contador Automático de Rótulos Rolo a Rolo', 'Estação de contagem e inspeção de qualidade rolo a rolo', 'especiales', 'Sensor Ultrassônico + Fotoelétrico de Alta Frequência',
    'Até 300 m/min', '100% de Precisão na Contagem', '35 cm (13.7")', 'Unidade indispensável para o controle de qualidade final e expedição de rótulos. Conta com precisão absoluta rótulos opacos, transparentes (clear-on-clear) e metalizados em altíssima velocidade, com parada automática pré-programada.', 'CONTROLE QA',
    '/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-automatico-rotulos-principal.webp', '["/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-automatico-rotulos-principal.webp","/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-rotulos-modelo-clm111.webp","/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-rotulos-modelo-csr111.webp","/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-rotulos-estacion-bobinado.webp","/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-rotulos-card.webp"]'::jsonb, '/maquinas/contador-de-automatico-de-etiquetas-web_red.pdf', 'https://katundps.com/katun-dps-home/impresoras-digitales-injekt/contador-de-automatico-de-etiquetas/', NULL,
    '["Detecção ultrassônica de lacuna ideal para materiais transparentes sobre liner transparente","Contagem dupla por número de etiquetas ou metragem linear percorrida","Sistema de desaceleração suave e parada automática ao atingir a meta estipulada","Rebobinador de alta tensão para carretéis firmes e prontos para aplicação industrial"]'::jsonb, '[{"label":"VELOCIDADE MÁXIMA","value":"300 m/min"},{"label":"SENSORES","value":"Óptico fotoelétrico + Ultrassônico de fenda"},{"label":"DIÂMETRO MÁX. ROLO","value":"400 mm"},{"label":"LARGURA DA BANDA","value":"Até 350 mm"}]'::jsonb, '["Controle de Qualidade","Expedição Final","Indústria Farmacêutica GXP"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    subtitle = EXCLUDED.subtitle,
    category = EXCLUDED.category,
    technology = EXCLUDED.technology,
    speed = EXCLUDED.speed,
    resolution = EXCLUDED.resolution,
    max_width = EXCLUDED.max_width,
    description = EXCLUDED.description,
    badge = EXCLUDED.badge,
    image = EXCLUDED.image,
    gallery = EXCLUDED.gallery,
    pdf_url = EXCLUDED.pdf_url,
    web_url = EXCLUDED.web_url,
    video_url = EXCLUDED.video_url,
    features = EXCLUDED.features,
    specs = EXCLUDED.specs,
    industries = EXCLUDED.industries,
    updated_at = CURRENT_TIMESTAMP;


-- --------------------------------------------------------------------
-- 2. TABLAS DE FORMULARIOS Y CAPTACIÓN DE LEADS
-- --------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS contact_submissions (
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

CREATE TABLE IF NOT EXISTS sample_requests (
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

CREATE TABLE IF NOT EXISTS roi_simulations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    run_quantity INTEGER NOT NULL,
    designs_count INTEGER NOT NULL,
    dps_prep_minutes INTEGER NOT NULL,
    dps_total_minutes INTEGER NOT NULL,
    user_email TEXT,
    company_name TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------------
-- 3. TABLAS DE BLOG, CMS Y ROLES (RBAC)
-- --------------------------------------------------------------------

DO $$ BEGIN
    CREATE TYPE blog_user_role AS ENUM ('superadmin', 'admin', 'editor', 'author');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE blog_post_status AS ENUM ('draft', 'published', 'archived');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE TABLE IF NOT EXISTS blog_profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    avatar_url TEXT DEFAULT '',
    role blog_user_role NOT NULL DEFAULT 'author',
    permissions JSONB NOT NULL DEFAULT '{
        "can_publish": false,
        "can_delete": false,
        "can_manage_users": false,
        "can_edit_all": false
    }'::jsonb,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS blog_posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    summary TEXT NOT NULL DEFAULT '',
    content_html TEXT DEFAULT '',
    canvas_blocks JSONB NOT NULL DEFAULT '[]'::jsonb,
    featured_image TEXT NOT NULL DEFAULT '',
    category TEXT NOT NULL DEFAULT 'Tecnología',
    tags TEXT[] NOT NULL DEFAULT '{}',
    author_id UUID REFERENCES blog_profiles(id) ON DELETE SET NULL,
    author_name TEXT NOT NULL DEFAULT 'Aleydis Reyes',
    author_avatar TEXT DEFAULT 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=200&q=80',
    status blog_post_status NOT NULL DEFAULT 'published',
    reading_time INTEGER NOT NULL DEFAULT 5,
    views_count BIGINT NOT NULL DEFAULT 0,
    seo_title TEXT DEFAULT '',
    seo_description TEXT DEFAULT '',
    published_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS blog_activity_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES blog_profiles(id) ON DELETE SET NULL,
    user_email TEXT,
    action TEXT NOT NULL,
    target_id TEXT,
    details JSONB DEFAULT '{}'::jsonb,
    ip_address TEXT DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Seed de perfiles de administradores
INSERT INTO blog_profiles (email, full_name, role, permissions, avatar_url)
VALUES 
('admin@katundps.com', 'Administrador Principal Katun', 'superadmin', '{"can_publish": true, "can_delete": true, "can_manage_users": true, "can_edit_all": true}'::jsonb, 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=200&q=80'),
('editor@katundps.com', 'Editor DPS', 'editor', '{"can_publish": true, "can_delete": false, "can_manage_users": false, "can_edit_all": true}'::jsonb, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80'),
('aleydis.reyes@katun.com', 'Aleydis Reyes', 'editor', '{"can_publish": true, "can_delete": false, "can_manage_users": false, "can_edit_all": true}'::jsonb, 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=200&q=80')
ON CONFLICT (email) DO UPDATE SET
    full_name = EXCLUDED.full_name,
    avatar_url = EXCLUDED.avatar_url;

-- Seed del artículo oficial de Aleydis Reyes (con avatar del gatito)
INSERT INTO blog_posts (
    slug, title, summary, featured_image, category, tags,
    author_name, author_avatar, status, reading_time,
    seo_title, seo_description, published_at
) VALUES (
    'impresion-digital-vs-flexografica-cual-elegir-para-etiquetas',
    'Impresión Digital vs Flexográfica: ¿Cuál Elegir para Etiquetas?',
    'Analizamos a fondo las diferencias clave, ventajas, costos y tabla comparativa entre la impresión digital y la flexografía tradicional para la toma de decisiones en plantas de etiquetado.',
    'https://images.unsplash.com/photo-1563770660941-20978e870e26?auto=format&fit=crop&w=1200&q=80',
    'Tecnología',
    ARRAY['Impresión Digital', 'Flexografía', 'Etiquetas Adhesivas', 'Costos de Producción', 'Tecnología de Impresión'],
    'Aleydis Reyes',
    'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=200&q=80',
    'published',
    5,
    'Impresión Digital vs Flexográfica: ¿Cuál Elegir para Etiquetas? | Katun DPS',
    'Descubre las diferencias entre la impresión digital y la flexografía en costos, tiradas, tiempos de entrega y calidad para la industria de etiquetas.',
    NOW()
)
ON CONFLICT (slug) DO UPDATE SET
    author_avatar = EXCLUDED.author_avatar,
    author_name = EXCLUDED.author_name;
