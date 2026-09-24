import { createClient, type SupabaseClient } from '@supabase/supabase-js';
import { MACHINES, type Machine } from '../data/machines';

// Configuração de URL e ANON KEY
const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL || import.meta.env.SUPABASE_URL || '';
const supabaseKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY || import.meta.env.SUPABASE_KEY || '';

export let supabase: SupabaseClient | null = null;

if (supabaseUrl && supabaseKey) {
  try {
    supabase = createClient(supabaseUrl, supabaseKey, {
      auth: { persistSession: false }
    });
  } catch (e) {
    console.warn('Não foi possível inicializar cliente Supabase, utilizando dados locais de fallback.', e);
    supabase = null;
  }
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

// Fallback de Indústrias locais em Português
export const LOCAL_INDUSTRIES: IndustryData[] = [
  {
    slug: 'bebidas',
    title: 'Indústria de Bebidas',
    tag: 'VINHO, CERVEJA & DESTILADOS',
    icon: 'wine_bar',
    image: 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?auto=format&fit=crop&w=800&q=80',
    description: 'Ampla variedade em tecnologia digital de impressão de rótulos que permite aos convertedores e marcas produzir facilmente seus próprios rótulos para vinhos, cervejas artesanais e destilados. Materiais especiais com textura, resistência total à umidade, condensação e balde de gelo, sem quantidades mínimas de tiragem.',
    subsections: ['Vinho e Cerveja Artesanal', 'Sem Pedido Mínimo (Zero Clichê)', 'Substratos Especiais e Texturizados', 'Resistência a Umidade e Gelo'],
    recommendedMachines: ['ArrowJet Aqua 330R', 'VIP Color VP660 / VP610', 'Katun DPS LT330']
  },
  {
    slug: 'quimica',
    title: 'Indústria Química e GHS',
    tag: 'ROTULAGEM GHS & BS5609',
    icon: 'science',
    image: 'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=800&q=80',
    description: 'A impressão digital de rótulos químicos oferece agilidade imediata para adaptação às normas regulatórias globais GHS e BS5609. Tintas aquosas pigmentadas com resistência extrema a solventes, óleos e intempéries, mantendo vivacidade de cor e legibilidade crítica.',
    subsections: ['Rótulos para Químicos e Lubrificantes', 'Embalagens Flexíveis', 'Conformidade GHS e Normas Internacionais', 'Tintas Pigmentadas de Alta Resistência'],
    recommendedMachines: ['ArrowJet Aqua 330R', 'Taurus 35 PL Plus Láser CO2', 'Arrow EzCut 350R']
  },
  {
    slug: 'alimentos',
    title: 'Alimentos e Embalagens Flexíveis',
    tag: 'EMBALAGENS FLEXÍVEIS & POUCH',
    icon: 'shopping_bag',
    image: 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?auto=format&fit=crop&w=800&q=80',
    description: 'Soluções completas para produção de rótulos alimentícios e embalagens flexíveis (sachês, stand-up pouch e bolsas Mylar). Impressão de alta resolução compatível com normas de contato indireto e integração com linhas de envase.',
    subsections: ['Embalagens de Alimentos e Café', 'Bolsas Mylar e Sachês Flexíveis', 'Tintas Homologadas para Contato Indireto', 'Integração com Equipamentos VFFS / HFFS'],
    recommendedMachines: ['Katun DPS KLT3', 'Gemini 40', 'VIP Color VP660 / VP610']
  },
  {
    slug: 'produtos-varios',
    title: 'Produtos Gerais & Sob Demanda',
    tag: 'ON-DEMAND & CURTAS TIRAGENS',
    icon: 'inventory_2',
    image: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=800&q=80',
    description: 'Imprima exatamente o que você precisa sob demanda, de 1 rótulo a 50.000 unidades, eliminando custos de estoque e desperdício de material obsoleto. Flexibilidade para campanhas promocionais, personalização e múltiplos SKUs.',
    subsections: ['Rótulos para Embalagens Comerciais', 'Rotulagem Logística e Varejo', 'Produção Rápida In-House', 'Flexibilidade de 1 a 50.000 Unidades'],
    recommendedMachines: ['VIP Color VP660 / VP610', 'Katun DPS LT330', 'Aries 35 PL']
  },
  {
    slug: 'farmaceutica',
    title: 'Indústria Farmacêutica & Saúde',
    tag: 'RASTREABILIDADE & CÓDIGO QR',
    icon: 'medication',
    image: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=800&q=80',
    description: 'Microimpressão em alta resolução para frascos, ampolas e caixas, com controle rigoroso de rastreabilidade, códigos 2D Datamatrix e QR codes dinâmicos. Sistemas de corte com precisão micrométrica e laminação protetora.',
    subsections: ['Rastreabilidade e Serialização QR', 'Micropolimento e Laminação Protetora', 'Otimização de Inventário Farmacêutico', 'Conformidade Regulatória GXP'],
    recommendedMachines: ['VIP Color VP660 / VP610', 'Taurus 35 PL Plus Láser CO2', 'Contador Automático de Rótulos Rolo a Rolo']
  },
  {
    slug: 'grafica',
    title: 'Indústria Gráfica & Sinalização',
    tag: 'SINALIZAÇÃO & MATERIAIS ESPECIAIS',
    icon: 'palette',
    image: 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=800&q=80',
    description: 'Sistemas industriais para produção gráfica em substratos adesivos, vinil, papéis fotográficos e filmes especiais. Alta produtividade com corte digital de precisão sem matriz mecânica.',
    subsections: ['Sinalização e Comunicação Visual', 'Rótulos Técnicos Industriais', 'Substratos Especiais e Películas Metalizadas', 'Corte Digital Tangencial e Semi-Rotativo'],
    recommendedMachines: ['Katun DPS KLT3', 'Arrow EzCut 330 RX', 'Katun DPS LT330']
  },
  {
    slug: 'fabricacao',
    title: 'Manufatura & Indústria Geral',
    tag: 'NORMAS OSHA, UL, GHS, ANSI',
    icon: 'precision_manufacturing',
    image: 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80',
    description: 'Sistemas robustos para criação de etiquetas duráveis para identificação de patrimônio, equipamentos elétricos, chicotes e painéis de controle, com certificação para as normas mais exigentes de durabilidade térmica e química.',
    subsections: ['Etiquetas Técnicas para Equipamentos', 'Certificações UL, OSHA, ANSI', 'Operação Contínua 24/7', 'Prensas Digitais e Cortadoras Industriais'],
    recommendedMachines: ['ArrowJet Aqua 330R', 'Katun DPS LT330', 'Cortadora de Rótulos por Folha LC 350 PM']
  }
];

export async function getIndustries(): Promise<IndustryData[]> {
  return LOCAL_INDUSTRIES;
}

export async function getProducts(): Promise<Machine[]> {
  return MACHINES;
}

export async function getCatalogs(): Promise<CatalogData[]> {
  return MACHINES.map(m => ({
    id: m.id,
    title: m.name,
    description: m.subtitle,
    pdf_url: m.pdfUrl,
    category: m.category,
    product_slug: m.id
  }));
}
