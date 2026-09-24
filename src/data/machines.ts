export interface MachineSpec {
  label: string;
  value: string;
}

export interface Machine {
  id: string;
  name: string;
  subtitle: string;
  category: 'impresoras' | 'cortadoras' | 'especiales';
  technology: string;
  speed: string;
  resolution: string;
  maxWidth: string;
  description: string;
  features: string[];
  specs: MachineSpec[];
  industries: string[];
  pdfUrl: string;
  webUrl?: string;
  videoUrl?: string;
  badge?: string;
  image: string;
  gallery?: string[];
}

export const MACHINES: Machine[] = [
  // ═══════════════════════════════════════════════════
  // SEÇÃO 1: EQUIPAMENTOS INKJET (IMPRESSÃO DIGITAL)
  // ═══════════════════════════════════════════════════
  {
    id: "vipcolor-vp610-vp660",
    name: "VIP Color VP660 / VP610",
    subtitle: "Impressora digital de rótulos por injeção direta de tinta, acabamento brilhante e resistente à água",
    category: "impresoras",
    technology: "Memjet Versapass®",
    speed: "Até 18 m/min (305 mm/s)",
    resolution: "1600 x 1600 dpi",
    maxWidth: "20 cm (8\")",
    description: "Impressora digital de mesa de alto desempenho para rótulos e etiquetas coloridas sob demanda. Cabeçote com 70.000 bicos de microinjeção, ideal para tiragens curtas e médias sem custo de pré-impressão ou clichês.",
    badge: "MAIS POPULAR",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-roll-to-roll-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-roll-to-roll-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-frontal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-perspectiva.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/01_VIP_Color_VP660_VP610/vipcolor-vp660-web-card.webp"
    ],
    pdfUrl: "/maquinas/02-katun-dps-impresora-vp-610-660-web_.pdf",
    webUrl: "https://katundps.com/katun-dps-home/impresoras-digitales-injekt/impresora-vip-color-uvp-660/",
    videoUrl: "https://www.youtube.com/embed/QFKxWpR_XJQ",
    features: [
      "Cabeçote industrial com 70.000 bicos de microinjeção",
      "Imprime até 2.400 etiquetas (4x6\") em apenas 10 minutos",
      "Cartuchos individuais CMYK de alta capacidade (250 ml)",
      "Design de mesa compacto para laboratório ou linha de envase",
      "Zero tempo de preparação comparado à flexografia tradicional"
    ],
    specs: [
      { label: "TECNOLOGIA", value: "Memjet Versapass Single Pass" },
      { label: "VELOCIDADE ALTA RES.", value: "9 m/min a 1600x1600 dpi" },
      { label: "LARGURA DE IMPRESSÃO", value: "20 cm (8\")" },
      { label: "CAPACIDADE TINTA", value: "Tanques individuais de 250ml CMYK" }
    ],
    industries: ["Alimentos Refrigerados", "Saúde e Nutrição", "Cuidados Pessoais", "Cosméticos"]
  },
  {
    id: "aquajet-330-hybrid-pro-m",
    name: "ArrowJet Aqua 330R - Hybrid PRO M",
    subtitle: "Prensa digital híbrida para rótulos de alta resolução e embalagens flexíveis com primer e verniz",
    category: "impresoras",
    technology: "Memjet DuraFlex® Híbrida",
    speed: "Até 21 m/min",
    resolution: "1600 x 1600 dpi",
    maxWidth: "32,4 cm (12.75\")",
    description: "O sistema 'tudo-em-um' definitivo para conversão de rótulos. Imprime digitalmente em altíssima definição, aplica laminação a frio, corta em contorno e remove a matriz de refile em uma única passagem contínua.",
    badge: "HÍBRIDA PRO",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/02_ArrowJet_Aqua_330R_Hybrid_PRO_M/arrowjet-aqua-330r-hybrid-pro-m-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/02_ArrowJet_Aqua_330R_Hybrid_PRO_M/arrowjet-aqua-330r-hybrid-pro-m-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/02_ArrowJet_Aqua_330R_Hybrid_PRO_M/arrowjet-aqua-330r-hybrid-pro-m-angulo.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/02_ArrowJet_Aqua_330R_Hybrid_PRO_M/arrowjet-aqua-330r-hybrid-pro-m-vista-catalogo.webp"
    ],
    pdfUrl: "/maquinas/04-katun-dps-impresora-aqua-jet-330-hybrid-pro-m-web_.pdf",
    webUrl: "https://katundps.com/katun-dps-home/impresoras-digitales-injekt/arrowjet-aqua-330r-hybrid-pro-m/",
    videoUrl: "https://www.youtube.com/embed/D_fF7Vav0O4",
    features: [
      "Processo completo: da bobina virgem ao rótulo acabado e rebobinado",
      "Módulo de laminação a frio e despalilhador sincronizado",
      "Sistema de corte de contorno de alta precisão integrado",
      "Rebobinador de matriz residual incorporado"
    ],
    specs: [
      { label: "IMPRESSÃO", value: "Digital CMYK Memjet DuraFlex" },
      { label: "LAMINAÇÃO", value: "Laminador a frio automático integrado" },
      { label: "LARGURA MÁXIMA", value: "32,4 cm (12.75\")" },
      { label: "VELOCIDADE", value: "Até 21 m/min" }
    ],
    industries: ["Vinhos e Destilados", "Farmacêutica", "Químicos GHS", "Rótulos Premium"]
  },
  {
    id: "katun-lt330",
    name: "Katun DPS LT330",
    subtitle: "Impressora digital de rótulos CMYK + Branco em bobina contínua",
    category: "impresoras",
    technology: "Digital LED HD (Toner Seco)",
    speed: "9,14 m/min",
    resolution: "1200 x 1200 dpi",
    maxWidth: "32 cm (12.6\")",
    description: "Solução versátil e econômica com tecnologia toner seco LED HD para impressão CMYK + Branco sobre materiais transparentes, metalizados, papéis texturizados e filmes sintéticos sem necessidade de pré-tratamento (primer).",
    badge: "CMYK + BRANCO",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-perspectiva-3d.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-estacion-cmykw.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-vista-lateral.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/04_Katun_DPS_LT330/katun-dps-lt330-card-frontal.webp"
    ],
    pdfUrl: "/maquinas/03-katun-dps-impresora-lt330-web-.pdf",
    webUrl: "https://katundps.com/katun-dps-home/impresoras-digitales-injekt/impresora-de-etiquetas-lt330-cmyk-blanco/",
    videoUrl: "https://www.youtube.com/embed/xmQ32C1a-yk",
    features: [
      "Fusão seca LED de alta definição com excelente ancoragem",
      "Branco de alta opacidade para fundos em materiais transparentes e metálicos",
      "Operação intuitiva sem necessidade de técnico especializado",
      "Registro micrométrico em rótulos multicoloridos"
    ],
    specs: [
      { label: "CONFIGURAÇÃO", value: "CMYK + Branco de alta opacidade" },
      { label: "RESOLUÇÃO", value: "1200 x 1200 dpi" },
      { label: "LARGURA DA BANDA", value: "330 mm (13\")" },
      { label: "VELOCIDADE", value: "9,14 m/min" }
    ],
    industries: ["Rótulos Industriais", "Sinalização", "Bebidas e Cervejarias", "Pequenas e Médias Tiragens"]
  },
  {
    id: "katun-klt3",
    name: "Katun DPS KLT3",
    subtitle: "Impressora industrial de rótulos rolo a rolo CMYK de alta produtividade",
    category: "impresoras",
    technology: "Inkjet Piezoelétrico UV / Água",
    speed: "Até 30 m/min",
    resolution: "1200 x 1200 dpi",
    maxWidth: "33 cm (13\")",
    description: "Prensa digital industrial robusta projetada para regime contínuo 24/7. Cabeçotes piezoelétricos industriais com cura UV LED de baixa temperatura, oferecendo máxima vivacidade de cor e durabilidade extrema aos elementos.",
    badge: "INDÚSTRIA 24/7",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-hd.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-modulo-impresion.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-vista-operativa.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/05_Katun_DPS_KLT3/katun-dps-klt3-uv-card.webp"
    ],
    pdfUrl: "/maquinas/05-katun-dps-impresora-klt3_web.pdf",
    webUrl: "https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/klt3-impresora-de-etiquetas/",
    videoUrl: "https://www.youtube.com/embed/NMrxJahHZ-A",
    features: [
      "Cabeçotes piezoelétricos industriais com tecnologia de gota variável",
      "Cura UV LED fria compatível com filmes termo-sensíveis",
      "Excelente resistência química e à radiação solar",
      "Construção em aço usinado de padrão industrial para operação contínua"
    ],
    specs: [
      { label: "CABEÇOTES", value: "Piezoelétricos industriais" },
      { label: "CURA", value: "UV LED Cold-Cure" },
      { label: "LARGURA DA BANDA", value: "330 mm" },
      { label: "VELOCIDADE", value: "Até 30 m/min" }
    ],
    industries: ["Químicos e Lubrificantes", "Cosméticos", "Decoração", "Vinhos e Destilados"]
  },
  {
    id: "arrowjet-aqua-330r",
    name: "ArrowJet Aqua 330R",
    subtitle: "Impressora digital de injeção de tinta pigmentada de alta velocidade para rótulos e embalagens flexíveis",
    category: "impresoras",
    technology: "Memjet DuraFlex®",
    speed: "Até 21 m/min (69 ft/min)",
    resolution: "1600 x 1600 dpi",
    maxWidth: "32,4 cm (12.75\")",
    description: "Prensa digital líder para bobinas de rótulos e embalagens flexíveis pouch/Mylar. Equipada com cabeçote Memjet DuraFlex de alta durabilidade e secador infravermelho próximo (NIR) instantâneo para tintas pigmentadas à base de água resistentes à luz e água.",
    badge: "MÁXIMA VELOCIDADE",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-principal-2025.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-principal-2025.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-render-hd.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-frontal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/01_Impresoras_Digitales/03_ArrowJet_Aqua_330R/arrowjet-aqua-330r-perspectiva.webp"
    ],
    pdfUrl: "/maquinas/01-katun-dps-impresora-aqua-330r-web-2_.pdf",
    webUrl: "https://katundps.com/katun-dps-home/impresoras-digitales-injekt/arrowjet-aqua-330r/",
    videoUrl: "https://www.youtube.com/embed/6CFHlWSeYQU",
    features: [
      "Cabeçote único CMYK Memjet DuraFlex com vida útil prolongada",
      "Secagem ultra-rápida por Infravermelho Próximo (NIR)",
      "Tintas pigmentadas base água resistentes à umidade, atrito e luz UV",
      "Homologada para rótulos alimentícios e químicos conforme normas internacionais",
      "Tanques industriais de tinta de 2L a 10L para produção ininterrupta"
    ],
    specs: [
      { label: "TIPO IMPRESSÃO", value: "CMYK em cabeçote único Single Pass" },
      { label: "RESOLUÇÃO", value: "1600x1600 dpi ou 1600x954 dpi" },
      { label: "LARGURA MÁXIMA ROLO", value: "38,1 cm (15\")" },
      { label: "LARGURA ÚTIL IMPRESSÃO", value: "32,4 cm (12.75\")" },
      { label: "DIÂMETRO DO ROLO", value: "50 cm (19.7\")" },
      { label: "SUBSTRATOS", value: "Papel couché/brilhante, PP, PET, PVC, BOPP, Mylar" }
    ],
    industries: ["Alimentos e Bebidas", "Químicos e Industriais", "Farmacêutica", "Limpeza e Higiene"]
  },

  // ═══════════════════════════════════════════════════
  // SEÇÃO 2: CORTADORAS E FINALIZADORAS DE RÓTULOS
  // ═══════════════════════════════════════════════════
  {
    id: "kf30x",
    name: "Cortadora KF30X",
    subtitle: "Cortadora digital de rótulos rolo a rolo com 1 lâmina tangencial de alta precisão",
    category: "cortadoras",
    technology: "Lâmina Tangencial Digital (1 Lâmina)",
    speed: "Cerca de 1 m/min",
    resolution: "< ±0.08 mm (Câmera CCD)",
    maxWidth: "33 cm (12.9\")",
    description: "Cortadora e finalizadora digital rolo a rolo compacta e precisa. Equipada com 1 lâmina tangencial digital de altíssima definição (sem custo de matrizes mecânicas), câmera CCD para alinhamento automático de marcas de registro, laminação a frio e rebobinamento de matriz residual.",
    badge: "1 LÂMINA TANGENCIAL",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-principal-hq.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-principal-hq.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-frontal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-cabezal-tangencial.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-rebobinado-merma.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-panel-control.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/01_Cortadora_KF30X/cortadora-kf30x-card.webp"
    ],
    pdfUrl: "/maquinas/cortadora-kf30x-brochure-web.pdf",
    webUrl: "https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/cortadora-etiquetas-kf30x/",
    features: [
      "Sistema de 1 lâmina tangencial digital de altíssima precisão de corte",
      "Velocidade de trabalho próxima a 1 m/min para máxima definição de bordas e curvas complexas",
      "Câmera CCD para reconhecimento automático de marcas de corte",
      "Laminador a frio e removedor automático de matriz de refile",
      "Estrutura robusta antivibração com tela touchscreen de 7 polegadas"
    ],
    specs: [
      { label: "SISTEMA DE CORTE", value: "1 lâmina tangencial digital de alta precisão" },
      { label: "VELOCIDADE REAL", value: "Cerca de 1 m/min (15 cm/min passo a passo)" },
      { label: "ÁREA MÁX. CORTE", value: "33 cm x 33 cm (12.9\" x 12.9\")" },
      { label: "DIÂMETRO MÁX. ROLO", value: "35,5 cm (14\")" },
      { label: "SENSOR DE REGISTRO", value: "Câmera CCD de alta definição" }
    ],
    industries: ["Rótulos Adesivos", "Rotulagem Sob Demanda", "Pequenas e Médias Tiragens"]
  },
  {
    id: "arrow-ezcut-vr-240x",
    name: "Arrow EzCut VR 240 X",
    subtitle: "Cortadora digital de mesa para rótulos rolo a rolo",
    category: "cortadoras",
    technology: "Plotter de Lâmina Drag Knife",
    speed: "Até 6 m/min",
    resolution: "±0.1 mm",
    maxWidth: "24 cm (9.4\")",
    description: "Solução de acabamento compacta e acessível de mesa para gráficas rápidas, convertedores e fabricantes que desejam automatizar o corte de rótulos em bobina com laminação integrada.",
    badge: "COMPACTA DE MESA",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-vista-general.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-modulo-corte-dragknife.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/02_Arrow_EzCut_VR_240_X/arrow-ezcut-vr-240x-traccion-bobina.webp"
    ],
    pdfUrl: "/maquinas/arrow-ezcut-vr-240xbrochure-web_compressed.pdf",
    webUrl: "https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/vr-240-x-cortadora-rollo-a-rollo/",
    features: [
      "Design de mesa ultracompacto para qualquer ambiente produtivo",
      "Laminação a frio e rebobinamento de desperdício em um só passo",
      "Importação direta de arquivos vetoriais DXF / PLT",
      "Operação silenciosa com manutenção simplificada"
    ],
    specs: [
      { label: "LARGURA DO ROLO", value: "240 mm (9.4\")" },
      { label: "VELOCIDADE CORTE", value: "Até 6 m/min" },
      { label: "TIPO DE LÂMINA", value: "Drag Knife orientada por sensor óptico" }
    ],
    industries: ["Pequenas Empresas", "Marcas Próprias", "Laboratórios de Teste"]
  },
  {
    id: "arrow-ezcut-330rx",
    name: "Arrow EzCut 330 RX",
    subtitle: "Troqueladora digital de rótulos rolo a rolo com facas pneumáticas contínuas",
    category: "cortadoras",
    technology: "Lâminas Pneumáticas Digitais",
    speed: "Até 18 m/min",
    resolution: "Precisão 0.05 mm",
    maxWidth: "33 cm (13\")",
    description: "Estação de acabamento digital avançada que integra laminação a frio, corte contínuo de contorno sem matrizes físicas através de lâminas com regulagem pneumática, refile longitudinal de bordas e rebobinamento duplo.",
    badge: "MULTI-LÂMINAS",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-principal-2025.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-principal-2025.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-angulo.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-perspectiva.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-sensor-posicionamiento.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-slitting.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-desbobinador.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/03_Arrow_EzCut_330_RX/arrow-ezcut-330-rx-extraccion-merma.webp"
    ],
    pdfUrl: "/maquinas/arrow-ezcut-330rx-brochure-web_compressed.pdf",
    webUrl: "https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/arrow-ezcut-330-rx/",
    features: [
      "Corte contínuo a partir de arquivo vetorial digital sem necessidade de facas de corte mecânicas",
      "Cabeçotes de corte com ajuste pneumático digital de pressão",
      "Laminação a frio de proteção e transparência integrada",
      "Extração e rebobinamento automático do esqueleto de rótulo excedente"
    ],
    specs: [
      { label: "LARGURA DA BANDA", value: "330 mm (13\")" },
      { label: "SISTEMA DE CORTE", value: "Lâminas de corte contínuo pneumáticas" },
      { label: "VELOCIDADE MÁXIMA", value: "Até 18 m/min" }
    ],
    industries: ["Rótulos sob Demanda", "Cervejarias Artesanais", "Cosméticos"]
  },
  {
    id: "arrow-ezcut-350r",
    name: "Arrow EzCut 350R",
    subtitle: "Cortadora digital de rótulos rolo a rolo de lâminas múltiplas de alta produtividade",
    category: "cortadoras",
    technology: "Corte Digital Multi-Lâmina (4 a 8 Lâminas)",
    speed: "Até 9 m/min",
    resolution: "Precisão < ±0.1 mm",
    maxWidth: "33 cm (13\")",
    description: "Cortadora digital de etiquetas e rótulos de lâminas múltiplas de rolo a rolo. Sistema completo com 4 a 8 cabeçotes de corte que operam simultaneamente com ajuste automático de distância entre facas, remoção de matriz, corte longitudinal até 100 m/min e computador integrado.",
    badge: "MULTI-LÂMINAS (4-8)",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/04_Arrow_EzCut_350R/arrow-ezcut-350r-principal-hd.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/04_Arrow_EzCut_350R/arrow-ezcut-350r-principal-hd.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/04_Arrow_EzCut_350R/arrow-ezcut-350r-equipo-real.webp"
    ],
    pdfUrl: "/maquinas/arrow-ezcut-350R-brochure-web-_compressed.pdf",
    webUrl: "https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/vr-230-cortadora-rollo-a-rollo-dps/",
    features: [
      "Sistema de corte simultâneo com 4 a 8 cabeçotes de lâminas de corte",
      "Ajuste automático motorizado da distância entre todos os cabeçotes",
      "Leitor óptico de alinhamento com câmera CCD de alta velocidade",
      "Módulo de laminação a frio e rebobinador de matriz residual integrado",
      "Corte longitudinal de tiras (slitting) em alta velocidade até 100 m/min"
    ],
    specs: [
      { label: "CABEÇOTES DE CORTE", value: "4 a 8 cabeçotes com facas de alta precisão" },
      { label: "VELOCIDADE DE CORTE", value: "9 m/min (29.5 pés/min)" },
      { label: "LARGURA MÁXIMA", value: "33 cm (13\") - Comprimento até 80 cm" },
      { label: "CORTE LONGITUDINAL", value: "Até 100 m/min com facas rotativas" },
      { label: "SISTEMA OPERACIONAL", value: "Computador industrial integrado com tela LCD" }
    ],
    industries: ["Farmacêutica", "Rótulos de Segurança", "Eletrônicos", "Cosméticos"]
  },
  {
    id: "aries-35pl",
    name: "Aries 35 PL",
    subtitle: "Finalizadora de rótulos semirrotativa servo-acionada de alta capacidade",
    category: "cortadoras",
    technology: "Troquelagem Semirrotativa Servo",
    speed: "Até 60 m/min",
    resolution: "Tolerância ±0.1 mm",
    maxWidth: "35 cm (13.7\")",
    description: "Finalizadora semirrotativa de alta performance para convertedores industriais. Integra troquelagem magnética semirrotativa servomotorizada, alinhamento por marca de registro, laminação, despalilhamento e corte longitudinal.",
    badge: "SEMIRROTATIVA",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-principal-hd.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-principal-hd.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-troquel-magnetico.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-laminacion-frio.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-control-tension.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-modulo-barniz.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/05_Aries_35_PL/aries-35-pl-panel-ajustes.webp"
    ],
    pdfUrl: "/maquinas/aries-35plbrochure-web_compressed.pdf",
    webUrl: "https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/aries-finalizadoras-de-etiquetas-semirotativas/",
    features: [
      "Velocidade de até 60 m/min em modo semirrotativo sincronizado",
      "Alinhamento óptico por leitura contínua de marca de registro",
      "Unidade de laminação de proteção e despalilhador de matriz",
      "Lâminas longitudinais para divisão de pistas (slitting) em múltiplos rolos"
    ],
    specs: [
      { label: "LARGURA DO SUBSTRATO", value: "350 mm (13.7\")" },
      { label: "VELOCIDADE MÁXIMA", value: "60 m/min" },
      { label: "ACIONAMENTO", value: "Servomotores digitais de alta resposta" }
    ],
    industries: ["Convertedores de Rótulos", "Gráficas Comerciais", "Indústria de Bebidas"]
  },
  {
    id: "taurus-pl-series",
    name: "Taurus 35 PL Plus Láser CO2",
    subtitle: "Finalizadora de rótulos com corte a laser CO2, laminação e mesa de vácuo",
    category: "cortadoras",
    technology: "Corte a Laser CO2 Galvanométrico Industrial",
    speed: "Até 70 m/min",
    resolution: "Submicrônica (Ponto laser 250 - 350 µm)",
    maxWidth: "35 cm (13.7\")",
    description: "Finalizadora digital industrial de rótulos e etiquetas com corte a laser CO2 de alta potência (150W a 350W). Elimina totalmente matrizes e clichês mecânicos, permitindo trocas instantâneas de formato, micropolimento de bordas, gravação e meio-corte a até 70 m/min.",
    badge: "LASER CO2 70 M/MIN",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-plus-laser-co2-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-plus-laser-co2-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-plus-laser-co2-modulo-corte.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-cuchillas-rotativas.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-slitting.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-guia-bobina.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-extraccion-merma.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/06_Taurus_35_PL_Plus_Laser_CO2/taurus-35-pl-lector-datamatrix.webp"
    ],
    pdfUrl: "/maquinas/taurus-25-pl-35pl-35pl-plus-brochure-web_compressed.pdf",
    webUrl: "https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/taurus-cortadoras-laser-para-etiquetas-con-laminado/",
    features: [
      "Fonte de laser CO2 selada de alta frequência com cabeçote galvanométrico",
      "Velocidade de corte contínuo a laser de até 70 m/min",
      "Mesa de sucção por vácuo multizona para perfeito assentamento da fita",
      "Corte de contornos complexos, microperfuração, vinco e meio-corte óptico",
      "Módulo de laminação e extração de esqueleto residual incorporados"
    ],
    specs: [
      { label: "FONTE LASER", value: "Laser CO2 RF de 150W a 350W (Sem lâminas mecânicas)" },
      { label: "VELOCIDADE MÁXIMA", value: "Até 70 m/min" },
      { label: "LARGURA DE TRABALHO", value: "Taurus 25 PL (250mm) / 35 PL Plus (350mm)" },
      { label: "MESA DE VÁCUO", value: "Platen servo-controlado de sucção contínua" },
      { label: "TIPOS DE CORTE", value: "Meio-corte, corte total, perfuração e gravação" }
    ],
    industries: ["Convertedores Industriais", "Farmacêutica de Grande Escala", "Indústria Automotiva", "Cosméticos High-End"]
  },
  {
    id: "gemini-40",
    name: "Gemini 40",
    subtitle: "Finalizadora de corte e acabamento de rótulos e embalagens por folha solta (Formato Máx. B3)",
    category: "cortadoras",
    technology: "Corte Digital por Folha com Plotter Graphtec",
    speed: "Até 12 m/min",
    resolution: "Câmera CCD Óptica",
    maxWidth: "35 cm x 50 cm (Formato B3)",
    description: "Equipamento compacto de mesa desenvolvido com tecnologia de plotter Graphtec para cortar contornos de rótulos adesivos, embalagens, cartões e impressos digitais em folhas avulsas. Conta com bandeja de alimentação automática estilo rampa para até 150 folhas e software Gemini Cutting Manager.",
    badge: "CORTE EM FOLHA (B3)",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-cortadora-pliego-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-cortadora-pliego-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-perspectiva-operacion.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-real-hd.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/07_Gemini_40/gemini-40-card.webp"
    ],
    pdfUrl: "/maquinas/brochue-cortadora-de-etiquetas-gemini-40-.pdf",
    webUrl: "https://katundps.com/katun-dps-home/maquinas-de-corte-y-finalizado-de-etiquetas-digitales/dpr-gemini-40-60-corte-yacabado-de-etiquetas-por-pliego/",
    features: [
      "Plotter Graphtec de precisão integrado para corte de folhas adesivas e cartão",
      "Bandeja de alimentação automática em rampa para até 150 folhas",
      "Câmera CCD integrada para leitura automática de marcas de registro em segundos",
      "Corte total, meio-corte de etiquetas e vinco para dobras de embalagens",
      "Software intuitivo Gemini Cutting Manager compatível com arquivos vetoriais"
    ],
    specs: [
      { label: "FORMATO MÁX. FOLHA", value: "B3 (353 mm x 500 mm / 19.69\" x 13.89\")" },
      { label: "GRAMATURA SUPORTADA", value: "Cartão 200 a 350 g/m² e folhas adesivas desde 170 g/m²" },
      { label: "ALIMENTADOR", value: "Automático com capacidade para 150 folhas" },
      { label: "TECNOLOGIA PLOTTER", value: "Graphtec industrial de lâmina orientada" }
    ],
    industries: ["Gráficas Digitais Sheetfed", "Design e Prototipagem", "Embalagens Promocionais"]
  },
  {
    id: "lc-350-pm",
    name: "Cortadora de Rótulos por Folha LC 350 PM",
    subtitle: "Cortadora digital por folha com alimentação automática e 2 lâminas (corte e vinco)",
    category: "cortadoras",
    technology: "Corte Digital por Folha com Dupla Lâmina (Corte + Vinco)",
    speed: "Até 12 cm/s (1,2 m/s)",
    resolution: "Menor que ±0.05 mm (Câmera CCD HD)",
    maxWidth: "35 cm (Largura Máx. da Folha)",
    description: "Cortadora digital de rótulos e embalagens por folha solta com alimentação automática contínua e motor de passo com encoder. Equipada com 1 lâmina para corte e 1 lâmina para vinco, câmera CCD HD para leitura de marcas de registro e QR code, operando com precisão nanométrica em papéis e sintéticos.",
    badge: "CORTE EM FOLHA (2 LÂMINAS)",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-angulo.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-lateral.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-alimentador.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-cabezal-doble-herramienta.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/02_Cortadoras_y_Finalizadoras/08_Cortadora_LC_350_PM/cortadora-lc-350-pm-card.webp"
    ],
    pdfUrl: "/maquinas/cortadora-de-etiquetas-lc-350-pm-katun-dps_nuevo-web.pdf",
    webUrl: "https://katundps.com/katun-dps-home/impresoras-digitales-injekt/lc-350-pm-cortadora-de-etiquetas-por-pliego/",
    features: [
      "Sistema de dupla ferramenta: 1 lâmina para corte contorno e 1 lâmina para vinco de embalagens",
      "Alimentação automática de folhas com rolos de tração de longa durabilidade",
      "Câmera CCD HD para alinhamento e leitura de código QR de troca automática de trabalho",
      "Display touchscreen LCD colorido de 4.3 polegadas com interface intuitiva",
      "Conectividade versátil via USB, Pen Drive, Wi-Fi e rede Ethernet"
    ],
    specs: [
      { label: "LÂMINAS DE TRABALHO", value: "1 lâmina para corte e 1 lâmina para vinco (dupla ferramenta)" },
      { label: "LARGURA MÁX. FOLHA", value: "35 cm (largura máxima de corte útil 32 cm)" },
      { label: "VELOCIDADE MÁXIMA", value: "12 cm/s (1,2 m/s)" },
      { label: "ESPESSURA SUPORTADA", value: "80g a 400g / até 1 mm de espessura" },
      { label: "PRESSÃO DA LÂMINA", value: "Regulável de 50g a 800g" },
      { label: "LEITURA DE REGISTRO", value: "Câmera HD para marcas em L, circulares ou QR Code" }
    ],
    industries: ["Gráficas Digitais", "Embalagens Rápidas", "Rótulos para Cosméticos e Alimentos", "Etiquetas por Folha"]
  },

  // ═══════════════════════════════════════════════════
  // SEÇÃO 3: CONTADOR DE RÓTULOS AUTOMÁTICO
  // ═══════════════════════════════════════════════════
  {
    id: "contador-automatico",
    name: "Contador Automático de Rótulos Rolo a Rolo",
    subtitle: "Estação de contagem e inspeção de qualidade rolo a rolo",
    category: "especiales",
    technology: "Sensor Ultrassônico + Fotoelétrico de Alta Frequência",
    speed: "Até 300 m/min",
    resolution: "100% de Precisão na Contagem",
    maxWidth: "35 cm (13.7\")",
    description: "Unidade indispensável para o controle de qualidade final e expedição de rótulos. Conta com precisão absoluta rótulos opacos, transparentes (clear-on-clear) e metalizados em altíssima velocidade, com parada automática pré-programada.",
    badge: "CONTROLE QA",
    image: "/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-automatico-rotulos-principal.webp",
    gallery: [
      "/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-automatico-rotulos-principal.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-rotulos-modelo-clm111.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-rotulos-modelo-csr111.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-rotulos-estacion-bobinado.webp",
      "/imagenes/CATALOGO_IMAGENES_WEB/03_Especiales_y_Control_Calidad/01_Contador_Automatico_de_Rotulos/contador-rotulos-card.webp"
    ],
    pdfUrl: "/maquinas/contador-de-automatico-de-etiquetas-web_red.pdf",
    webUrl: "https://katundps.com/katun-dps-home/impresoras-digitales-injekt/contador-de-automatico-de-etiquetas/",
    features: [
      "Detecção ultrassônica de lacuna ideal para materiais transparentes sobre liner transparente",
      "Contagem dupla por número de etiquetas ou metragem linear percorrida",
      "Sistema de desaceleração suave e parada automática ao atingir a meta estipulada",
      "Rebobinador de alta tensão para carretéis firmes e prontos para aplicação industrial"
    ],
    specs: [
      { label: "VELOCIDADE MÁXIMA", value: "300 m/min" },
      { label: "SENSORES", value: "Óptico fotoelétrico + Ultrassônico de fenda" },
      { label: "DIÂMETRO MÁX. ROLO", value: "400 mm" },
      { label: "LARGURA DA BANDA", value: "Até 350 mm" }
    ],
    industries: ["Controle de Qualidade", "Expedição Final", "Indústria Farmacêutica GXP"]
  }
];
