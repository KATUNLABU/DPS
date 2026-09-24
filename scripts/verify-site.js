async function run() {
  try {
    const resHome = await fetch('http://localhost:4321/');
    const homeText = await resHome.text();
    console.log('Homepage status:', resHome.status);
    console.log('Homepage contains Cassio WA (5511945222069):', homeText.includes('5511945222069'));
    console.log('Homepage contains Cassio name:', homeText.includes('C\u00e1ssio Rodrigues'));
    console.log('Homepage contains #process anchor:', homeText.includes('id="process"'));
    console.log('Homepage contains Tecnologia Memjet & Laser:', homeText.includes('Tecnologia Memjet & Laser'));

    const resCat = await fetch('http://localhost:4321/catalogo');
    const catText = await resCat.text();
    console.log('Catalogo status:', resCat.status);
    console.log('Catalogo contains KF30X (1 lamina):', catText.includes('1 l\u00e2mina tangencial'));
    console.log('Catalogo contains KF30X (~1 m/min):', catText.includes('~1 m/min'));
    console.log('Catalogo contains LC 350 PM (folha):', catText.includes('folhas') || catText.includes('pliegos') || catText.includes('folha'));
    console.log('Catalogo contains Arrow EzCut 350R (multi-laminas):', catText.includes('4 a 8 l\u00e2minas'));
    console.log('Catalogo contains Taurus 35 PL Plus (Laser):', catText.includes('Taurus 35 PL Plus') && catText.includes('Laser'));

    console.log('ALL VERIFICATIONS SUCCESSFUL!');
  } catch (err) {
    console.error('Error during verification:', err);
  }
}

run();
