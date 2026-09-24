/**
 * Script para sembrar la base de datos de Vultr (PostgreSQL)
 * Ejecución:
 *   DATABASE_URL="postgres://dps_user:tu_pass@IP_VULTR:5432/dps_catalog" bun scripts/seed-vultr.js
 */

import postgres from 'postgres';
import { MACHINES } from '../src/data/machines.ts';

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  console.error('\n❌ ERROR: Variable DATABASE_URL no encontrada.');
  console.log('Uso:');
  console.log('  DATABASE_URL="postgres://dps_user:TuPassword@IP_VULTR:5432/dps_catalog" bun scripts/seed-vultr.js\n');
  process.exit(1);
}

const sql = postgres(connectionString);

async function runSeed() {
  console.log('🚀 Conectando a PostgreSQL en Vultr...');

  try {
    // 1. Crear tabla si no existe
    console.log('📦 Asegurando existencia de tabla "machines"...');
    await sql`
      CREATE TABLE IF NOT EXISTS machines (
        id VARCHAR(100) PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        subtitle TEXT NOT NULL,
        category VARCHAR(50) NOT NULL,
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
    `;

    console.log(`📥 Insertando / actualizando ${MACHINES.length} equipos del catálogo...`);

    for (const machine of MACHINES) {
      await sql`
        INSERT INTO machines (
          id, name, subtitle, category, technology, speed, resolution,
          max_width, description, badge, image, gallery, pdf_url, web_url, video_url,
          features, specs, industries
        ) VALUES (
          ${machine.id},
          ${machine.name},
          ${machine.subtitle},
          ${machine.category},
          ${machine.technology},
          ${machine.speed},
          ${machine.resolution},
          ${machine.maxWidth},
          ${machine.description},
          ${machine.badge || null},
          ${machine.image},
          ${JSON.stringify(machine.gallery || [machine.image])},
          ${machine.pdfUrl},
          ${machine.webUrl || null},
          ${machine.videoUrl || null},
          ${JSON.stringify(machine.features)},
          ${JSON.stringify(machine.specs)},
          ${JSON.stringify(machine.industries)}
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
      `;
      console.log(`  ✓ [${machine.category.toUpperCase()}] ${machine.name}`);
    }

    console.log('\n🎉 ¡Catálogo cargado con éxito en tu VPS Vultr!');
    const count = await sql`SELECT COUNT(*) FROM machines`;
    console.log(`📊 Total de equipos en base de datos: ${count[0].count}\n`);

  } catch (err) {
    console.error('❌ Error sembrando base de datos:', err);
  } finally {
    await sql.end();
    process.exit(0);
  }
}

runSeed();
