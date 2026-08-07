import gsap from 'gsap';
import './style.css';

// DOM Elements
const logoKatun = document.getElementById('logo-katun');
const katunText = document.getElementById('katun');
const letterD = document.getElementById('d');
const puntoD = document.getElementById('punto_d');
const letterP = document.getElementById('p');
const puntoP = document.getElementById('punto_p');
const letterS = document.getElementById('s');
const puntoS = document.getElementById('punto_s');
const tmText = document.getElementById('tm');

const tapeStrip = document.getElementById('tapeStrip');
const centralSticker = document.getElementById('centralSticker');
const transparentWindow = document.getElementById('transparentWindow');
const clickPrompt = document.getElementById('clickPrompt');
const introScreen = document.getElementById('introScreen');
const floatingControls = document.getElementById('floatingControls');
const mainWebsiteContainer = document.getElementById('mainWebsiteContainer');
const btnPlayPause = document.getElementById('btnPlayPause');
const btnRestart = document.getElementById('btnRestart');
const btnBackToIntro = document.getElementById('btnBackToIntro');

// Active Timeline Reference
let activeTimeline = null;
let isPeeling = false;

// Precargar sitio web de fondo inmediatamente al cargar la página
function preloadWebsite() {
  if (mainWebsiteContainer) {
    gsap.set(mainWebsiteContainer, {
      display: 'block',
      opacity: 1,
      visibility: 'visible'
    });
  }
}

// Reset SVG & Intro State
function resetSVG() {
  preloadWebsite();

  const elements = [katunText, letterD, puntoD, letterP, puntoP, letterS, puntoS, tmText, logoKatun, tapeStrip, centralSticker].filter(Boolean);
  gsap.killTweensOf(elements);
  gsap.set(elements, { clearProps: 'all' });
  
  const svgElements = [puntoD, puntoP, puntoS, katunText, letterD, letterP, letterS, tmText, logoKatun].filter(Boolean);
  gsap.set(svgElements, {
    transformBox: 'fill-box',
    transformOrigin: 'center center'
  });

  if (clickPrompt) {
    clickPrompt.classList.remove('visible');
  }

  if (transparentWindow) {
    transparentWindow.classList.remove('active');
  }

  if (introScreen) {
    gsap.set(introScreen, { 
      clearProps: 'all',
      maskImage: 'none',
      webkitMaskImage: 'none',
      opacity: 1,
      display: 'flex'
    });
  }

  if (floatingControls) {
    gsap.set(floatingControls, { opacity: 1, display: 'flex' });
  }

  isPeeling = false;
}

// -------------------------------------------------------------
// FULLSCREEN INTRO ANIMATION (5.0 SECONDS EXACT)
// -------------------------------------------------------------
function createFullscreenIntroTimeline() {
  resetSVG();

  const tl = gsap.timeline({
    paused: false,
    onComplete: () => {
      updatePlayBtnIcon(false);
      if (clickPrompt) {
        clickPrompt.classList.add('visible');
      }
    }
  });

  const blurState = { blur: 22 };

  const labelWidth = Math.min(window.innerWidth * 0.20, 220);
  const margin = Math.min(window.innerWidth * 0.022, 28);
  const stepDistance = labelWidth + (margin * 2);
  const initialOffset = stepDistance * 3; // 3 Marcas CMYK al inicio

  // 1. Desplazamiento desde Marcas CMYK al inicio hasta el Logo central
  tl.fromTo(tapeStrip, 
    { x: initialOffset },
    { 
      x: 0, 
      duration: 4.7, 
      ease: 'power3.out' 
    },
    0
  )

  // 2. Disminución paulatinamente fluida del blur de movimiento (22px -> 0px)
  .to(blurState, {
    blur: 0,
    duration: 4.7,
    ease: 'power3.out',
    onUpdate: () => {
      gsap.set(tapeStrip, { filter: `blur(${blurState.blur.toFixed(1)}px)` });
    }
  }, 0)

  // 3. Freno seco de precisión en el segundo 5.0 exacto sobre el logo KATUN dps nítido
  .to(logoKatun, {
    scale: 1.06,
    duration: 0.15,
    yoyo: true,
    repeat: 1,
    ease: 'sine.inOut'
  }, 4.7);

  return tl;
}

// -------------------------------------------------------------
// CLIC INSTANTÁNEO: DESVANECIMIENTO RÁPIDO + ZOOM CON CONTORNO DIFUMINADO
// -------------------------------------------------------------
function triggerStickerPeelAndZoom() {
  if (isPeeling) return;
  isPeeling = true;

  if (clickPrompt) {
    clickPrompt.classList.remove('visible');
  }

  if (transparentWindow) {
    transparentWindow.classList.add('active');
  }

  if (floatingControls) {
    gsap.to(floatingControls, { opacity: 0, duration: 0.2 });
  }

  const initialRadius = Math.min(window.innerWidth * 0.10, 110);
  const maxRadius = Math.max(window.innerWidth, window.innerHeight) * 1.6;

  // FASE A: Desvanecimiento RÁPIDO del sticker (opacity: 0 en 0.25s)
  gsap.to(centralSticker, {
    opacity: 0,
    scale: 1.08,
    duration: 0.25,
    ease: 'power2.out'
  });

  // FASE B: Zoom In Inmediato desde t=0 con contorno difuminado (Blurred Stroke)
  const zoomState = { radius: initialRadius, scale: 1, opacity: 1 };

  gsap.to(zoomState, {
    radius: maxRadius,
    scale: 1.25,
    opacity: 0,
    duration: 1.15,
    ease: 'power3.inOut',
    onUpdate: function() {
      const r = zoomState.radius;
      const s = zoomState.scale;
      const o = zoomState.opacity;
      
      // Anillo con borde suave difuminado (feathered blurred stroke)
      const innerFeather = Math.max(0, r - 28);
      const outerFeather = r + 32;

      const maskString = `radial-gradient(circle at 50% 50%, transparent 0px, transparent ${innerFeather}px, rgba(0, 0, 0, 0.75) ${r}px, black ${outerFeather}px)`;

      gsap.set(introScreen, {
        maskImage: maskString,
        webkitMaskImage: maskString,
        scale: s,
        opacity: o
      });
    },
    onComplete: () => {
      gsap.set(introScreen, { display: 'none' });
    }
  });
}

// UI Play/Pause Icon Helper
function updatePlayBtnIcon(isPlaying) {
  if (!btnPlayPause) return;
  btnPlayPause.innerHTML = isPlaying
    ? `<svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><rect x="6" y="4" width="4" height="16"/><rect x="14" y="4" width="4" height="16"/></svg> Pausar`
    : `<svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><polygon points="5 3 19 12 5 21 5 3"/></svg> Reproducir`;
}

// Event Listeners
if (centralSticker) {
  centralSticker.addEventListener('click', triggerStickerPeelAndZoom);
}

if (clickPrompt) {
  clickPrompt.addEventListener('click', (e) => {
    e.stopPropagation();
    triggerStickerPeelAndZoom();
  });
}

if (btnPlayPause) {
  btnPlayPause.addEventListener('click', () => {
    if (!activeTimeline) return;
    if (activeTimeline.isActive()) {
      activeTimeline.pause();
      updatePlayBtnIcon(false);
    } else {
      if (activeTimeline.progress() === 1) {
        activeTimeline.restart();
      } else {
        activeTimeline.play();
      }
      updatePlayBtnIcon(true);
    }
  });
}

if (btnRestart) {
  btnRestart.addEventListener('click', () => {
    if (!activeTimeline) return;
    activeTimeline.restart();
    updatePlayBtnIcon(true);
  });
}

if (btnBackToIntro) {
  btnBackToIntro.addEventListener('click', () => {
    activeTimeline = createFullscreenIntroTimeline();
    updatePlayBtnIcon(true);
  });
}

// Window resize handler
window.addEventListener('resize', () => {
  if (activeTimeline && !isPeeling) {
    const isPlaying = activeTimeline.isActive();
    const currentProgress = activeTimeline.progress();
    activeTimeline = createFullscreenIntroTimeline();
    activeTimeline.progress(currentProgress);
    if (isPlaying) {
      activeTimeline.play();
    } else {
      activeTimeline.pause();
    }
  }
});

// Initialize Immediately & Preload
preloadWebsite();

document.addEventListener('DOMContentLoaded', () => {
  preloadWebsite();
  activeTimeline = createFullscreenIntroTimeline();
  updatePlayBtnIcon(true);
});

// Immediate execution fallback
activeTimeline = createFullscreenIntroTimeline();
updatePlayBtnIcon(true);
