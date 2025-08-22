<template>
  <div class="relative min-h-screen bg-gradient-to-br from-white via-pink-50/20 to-orange-50/10 overflow-x-hidden">
    <!-- Three.js Background Canvas -->
    <canvas 
      ref="canvasRef" 
      class="fixed inset-0 z-0 w-full h-full lg:left-72"
      :style="{ opacity: canvasOpacity }"
    />
    
    <!-- Progress Indicator -->
    <div class="fixed bottom-8 left-1/2 lg:left-1/2 lg:ml-36 transform -translate-x-1/2 z-50">
      <div class="flex items-center bg-black/20 backdrop-blur-sm rounded-full px-6 py-3">
        <span class="text-white/90 text-sm mr-4 font-medium">
          {{ currentPhotoIndex + 2 }} / {{ totalSections }}
        </span>
        <div class="w-32 h-1 bg-white/30 rounded-full overflow-hidden">
          <div 
            class="h-full bg-gradient-to-r from-pink-500 to-orange-500 rounded-full transition-all duration-700 ease-out"
            :style="{ width: progressPercentage + '%' }"
          ></div>
        </div>
      </div>
    </div>

    <!-- Section Title Indicator -->
    <div class="fixed top-8 right-8 z-50">
      <div class="bg-black/20 backdrop-blur-sm rounded-full px-6 py-3 text-white/90 text-sm font-medium">
        {{ currentSection.title }}
      </div>
    </div>

    <!-- Main Photo Container - Respects sidebar -->
    <div class="fixed inset-0 lg:left-72 z-10">
      <!-- Intro Section -->
      <section 
        class="h-full flex items-center justify-center relative overflow-hidden transition-all duration-1000"
        :class="{ 
          'opacity-100': currentPhotoIndex === -1, 
          'opacity-0 pointer-events-none': currentPhotoIndex !== -1 
        }"
      >
        <!-- Background Image -->
        <div class="absolute inset-0">
          <img 
            src="/img/fondo.jpg" 
            alt="Nuestra Historia"
            class="w-full h-full object-cover filter blur-sm"
          />
          <div class="absolute inset-0 bg-gradient-to-b from-black/60 via-black/40 to-black/70"></div>
        </div>
        
        <div class="relative z-10 text-center max-w-4xl mx-auto px-6">
          <h1 class="text-6xl lg:text-8xl font-bold mb-8 text-white drop-shadow-lg">
            <span class="block mb-4">Nuestra</span>
            <span class="bg-gradient-to-r from-pink-400 via-pink-500 to-orange-500 bg-clip-text text-transparent drop-shadow-lg">
              Historia
            </span>
          </h1>
          <p class="text-xl lg:text-2xl text-white/90 mb-12 max-w-3xl mx-auto leading-relaxed drop-shadow-md">
            Cada transformación cuenta una historia única de belleza, confianza y transformación personal
          </p>
          <div class="flex flex-col items-center animate-bounce">
            <div class="text-white/70 text-lg mb-4 font-medium drop-shadow-md">Descubre nuestro viaje</div>
            <div class="w-8 h-12 border-2 border-white/50 rounded-full flex justify-center relative overflow-hidden backdrop-blur-sm bg-white/10">
              <div class="w-2 h-4 bg-white/70 rounded-full mt-2 animate-pulse"></div>
            </div>
          </div>
        </div>
      </section>

      <!-- Photo Gallery Container -->
      <div 
        v-for="(photo, index) in allPhotos" 
        :key="index"
        class="absolute inset-0 transition-all duration-1000 ease-in-out"
        :class="{
          'opacity-100': currentPhotoIndex === index,
          'opacity-0 pointer-events-none': currentPhotoIndex !== index
        }"
        :style="{
          transform: currentPhotoIndex === index ? 'translateX(0%) scale(1)' : 
                     index > currentPhotoIndex ? 'translateX(100%) scale(0.9)' : 'translateX(-100%) scale(0.9)'
        }"
      >
        <!-- Background Image with Parallax -->
        <div class="absolute inset-0 overflow-hidden">
          <div 
            :ref="el => setImageRef(el, index)"
            class="w-full h-full transform transition-transform duration-2000 ease-out"
            :style="{ 
              transform: currentPhotoIndex === index ? 'scale(1)' : 'scale(1.1)',
            }"
          >
            <img 
              :src="photo.main" 
              :alt="photo.title"
              class="w-full h-full object-cover"
            />
          </div>
          <div class="absolute inset-0 bg-gradient-to-r from-black/70 via-black/30 to-black/70"></div>
        </div>

        <!-- Content Overlay -->
        <div class="relative z-10 h-full flex items-center justify-center">
          <div class="max-w-4xl mx-auto px-6 text-center">
            <div 
              class="transform transition-all duration-1000"
              :class="{
                'translate-y-0 opacity-100': currentPhotoIndex === index,
                'translate-y-10 opacity-0': currentPhotoIndex !== index
              }"
              :style="{ transitionDelay: currentPhotoIndex === index ? '300ms' : '0ms' }"
            >
              <!-- Section Title (only on first photo of each section) -->
              <div v-if="photo.isFirstInSection" class="mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-r from-pink-500 to-orange-500 rounded-full text-white text-xl font-bold mb-6 shadow-lg transform transition-all duration-700"
                  :class="{
                    'scale-100 rotate-0': currentPhotoIndex === index,
                    'scale-0 rotate-45': currentPhotoIndex !== index
                  }"
                  :style="{ transitionDelay: currentPhotoIndex === index ? '500ms' : '0ms' }">
                  <span>{{ photo.sectionNumber }}</span>
                </div>
                <h2 class="text-4xl lg:text-6xl font-bold mb-4 bg-gradient-to-r from-pink-400 to-orange-400 bg-clip-text text-transparent">
                  {{ photo.sectionTitle }}
                </h2>
                <div class="w-24 h-1 bg-gradient-to-r from-pink-500 to-orange-500 mx-auto rounded-full mb-8 transform transition-all duration-700"
                  :class="{
                    'scale-x-100': currentPhotoIndex === index,
                    'scale-x-0': currentPhotoIndex !== index
                  }"
                  :style="{ transitionDelay: currentPhotoIndex === index ? '600ms' : '0ms' }"></div>
              </div>

              <!-- Photo Content -->
              <div class="text-white">
                <h3 class="text-3xl lg:text-5xl font-bold mb-6 text-white transform transition-all duration-700"
                  :class="{
                    'translate-x-0 opacity-100': currentPhotoIndex === index,
                    'translate-x-10 opacity-0': currentPhotoIndex !== index
                  }"
                  :style="{ transitionDelay: currentPhotoIndex === index ? '700ms' : '0ms' }">
                  {{ photo.title }}
                </h3>
                <p class="text-lg lg:text-xl text-white/90 mb-6 max-w-2xl mx-auto leading-relaxed transform transition-all duration-700"
                  :class="{
                    'translate-y-0 opacity-100': currentPhotoIndex === index,
                    'translate-y-5 opacity-0': currentPhotoIndex !== index
                  }"
                  :style="{ transitionDelay: currentPhotoIndex === index ? '800ms' : '0ms' }">
                  {{ photo.description }}
                </p>
                <div class="inline-flex items-center bg-white/20 backdrop-blur-sm px-6 py-3 rounded-full transform transition-all duration-700"
                  :class="{
                    'scale-100 opacity-100': currentPhotoIndex === index,
                    'scale-90 opacity-0': currentPhotoIndex !== index
                  }"
                  :style="{ transitionDelay: currentPhotoIndex === index ? '900ms' : '0ms' }">
                  <div class="w-3 h-3 bg-pink-400 rounded-full mr-3 animate-pulse"></div>
                  <span class="text-pink-200 font-medium">{{ photo.category }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Timeline Section -->
      <div 
        class="absolute inset-0 transition-all duration-1000"
        :class="{
          'opacity-100': showTimeline,
          'opacity-0 pointer-events-none': !showTimeline
        }"
      >
        <div class="h-full bg-gradient-to-b from-white to-pink-50/30 py-20 relative overflow-hidden flex items-center">
          <div class="absolute inset-0 opacity-5">
            <div class="absolute inset-0" style="background-image: radial-gradient(circle at 30% 70%, var(--pink-pastel) 0%, transparent 50%), radial-gradient(circle at 70% 30%, var(--coral) 0%, transparent 50%);"></div>
          </div>
          
          <div class="relative z-10 max-w-4xl mx-auto px-6 w-full">
            <div class="text-center mb-20">
              <h2 class="text-5xl lg:text-7xl font-bold mb-6 bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
                Nuestra Evolución
              </h2>
              <div class="w-32 h-1 bg-gradient-to-r from-pink-500 to-orange-500 mx-auto rounded-full"></div>
            </div>

            <!-- Current Timeline Item -->
            <div 
              v-if="currentTimelineItem"
              class="flex items-center justify-center"
              :class="currentTimelineIndex % 2 === 0 ? 'flex-row' : 'flex-row-reverse'"
            >
              <!-- Image -->
              <div class="w-1/2 px-8">
                <div class="aspect-[4/3] rounded-3xl overflow-hidden shadow-2xl transform transition-all duration-1000"
                  :class="{
                    'scale-100 opacity-100': showTimeline,
                    'scale-95 opacity-0': !showTimeline
                  }">
                  <img 
                    :src="currentTimelineItem.image" 
                    :alt="currentTimelineItem.title"
                    class="w-full h-full object-cover hover:scale-105 transition-transform duration-700"
                  />
                </div>
              </div>

              <!-- Timeline Line -->
              <div class="flex-shrink-0 relative">
                <div class="w-1 h-32 bg-gradient-to-b from-pink-500 to-orange-500 mx-auto transform transition-all duration-1000"
                  :class="{
                    'scale-y-100': showTimeline,
                    'scale-y-0': !showTimeline
                  }"
                  :style="{ transitionDelay: '300ms' }"></div>
                <div class="absolute top-1/2 transform -translate-y-1/2 w-6 h-6 bg-gradient-to-r from-pink-500 to-orange-500 rounded-full border-4 border-white shadow-lg -translate-x-2.5 transition-all duration-1000"
                  :class="{
                    'scale-100 opacity-100': showTimeline,
                    'scale-0 opacity-0': !showTimeline
                  }"
                  :style="{ transitionDelay: '500ms' }"></div>
              </div>

              <!-- Content -->
              <div class="w-1/2 px-8">
                <div class="transform transition-all duration-1000"
                  :class="{
                    'translate-x-0 opacity-100': showTimeline,
                    'translate-x-10 opacity-0': !showTimeline && currentTimelineIndex % 2 === 0,
                    '-translate-x-10 opacity-0': !showTimeline && currentTimelineIndex % 2 === 1
                  }"
                  :style="{ transitionDelay: '700ms' }">
                  <div class="text-pink-500 font-bold text-lg mb-2">{{ currentTimelineItem.year }}</div>
                  <h3 class="text-3xl font-bold text-gray-800 mb-4">{{ currentTimelineItem.title }}</h3>
                  <p class="text-gray-600 text-lg leading-relaxed">{{ currentTimelineItem.description }}</p>
                </div>
              </div>
            </div>

            <!-- Timeline Navigation Dots -->
            <div class="flex justify-center mt-16 space-x-4">
              <div 
                v-for="(milestone, index) in timelineMilestones" 
                :key="index"
                class="w-3 h-3 rounded-full transition-all duration-300 cursor-pointer"
                :class="{
                  'bg-gradient-to-r from-pink-500 to-orange-500 scale-125': currentTimelineIndex === index,
                  'bg-pink-200 hover:bg-pink-300': currentTimelineIndex !== index
                }"
                @click="setTimelineItem(index)"
              ></div>
            </div>
          </div>
        </div>
      </div>

      <!-- CTA Section -->
      <div 
        class="absolute inset-0 transition-all duration-1000"
        :class="{
          'opacity-100': showCTA,
          'opacity-0 pointer-events-none': !showCTA
        }"
      >
        <div class="h-full bg-gradient-to-br from-pink-500 via-pink-600 to-orange-500 relative overflow-hidden flex items-center justify-center">
          <div class="absolute inset-0 bg-black/10"></div>
          <div class="absolute inset-0">
            <div class="absolute top-20 left-20 w-32 h-32 bg-white/10 rounded-full animate-pulse"></div>
            <div class="absolute bottom-32 right-32 w-20 h-20 bg-white/10 rounded-full animate-pulse delay-1000"></div>
            <div class="absolute top-1/2 left-10 w-16 h-16 bg-white/10 rounded-full animate-pulse delay-500"></div>
          </div>
          
          <div class="relative z-10 max-w-4xl mx-auto px-6 text-center transform transition-all duration-1000"
            :class="{
              'scale-100 opacity-100': showCTA,
              'scale-95 opacity-0': !showCTA
            }">
            <h2 class="text-5xl lg:text-6xl font-bold text-white mb-8">
              ¿Lista para tu<br>Transformación?
            </h2>
            <p class="text-xl lg:text-2xl text-white/90 mb-12 max-w-2xl mx-auto">
              Únete a nuestras clientas satisfechas y descubre tu mejor versión
            </p>
            
            <NuxtLink to="/">
              <button class="bg-white text-pink-600 font-bold px-12 py-4 rounded-full text-lg hover:bg-gray-50 transition-all duration-300 hover:scale-105 shadow-xl">
                Reservar Cita
              </button>
            </NuxtLink>
          </div>
        </div>
      </div>
    </div>

    <!-- Scroll Content - Creates the scrollable height -->
    <div class="relative z-0">
      <!-- Intro scroll area -->
      <section class="h-screen"></section>
      
      <!-- Photo scroll areas -->
      <section 
        v-for="(photo, index) in allPhotos" 
        :key="`scroll-${index}`"
        class="h-screen"
        :data-photo="index"
      ></section>
      
      <!-- Timeline scroll areas -->
      <section 
        v-for="(milestone, index) in timelineMilestones" 
        :key="`timeline-scroll-${index}`"
        class="h-screen" 
        :data-timeline="index"
      ></section>
      
      <!-- CTA scroll area -->
      <section class="h-screen"></section>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick, computed } from 'vue'
import * as THREE from 'three'
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

if (process.client) {
  gsap.registerPlugin(ScrollTrigger)
}

useHead({
  title: 'Galería - Toda Bonita',
  meta: [
    { name: 'description', content: 'Explora nuestra galería de transformaciones de belleza a través de una experiencia visual inmersiva.' },
    { name: 'keywords', content: 'galería, fotos, transformaciones, belleza, scrollytelling' }
  ]
})

// Refs
const canvasRef = ref(null)
const canvasOpacity = ref(0.3)
const currentPhotoIndex = ref(-1) // -1 for intro
const currentTimelineIndex = ref(0)
const imageRefs = ref([])

// Three.js variables
let scene, camera, renderer, particles, clock

// Photo Data
const photoSections = [
  {
    title: "Transformaciones Capilares",
    photos: [
      {
        title: 'Corte Bob Moderno',
        description: 'Transformación completa con corte bob texturizado y mechas californianas que realzan la personalidad única de cada cliente',
        category: 'Corte & Color',
        main: '/img/servicio_peluqueria.jpg'
      },
      {
        title: 'Balayage Caramelo',
        description: 'Técnica de balayage con tonos caramelo y dorados naturales que aportan luminosidad y movimiento al cabello',
        category: 'Colorimetría',
        main: '/img/servicio_peluqueria2.jpg'
      },
      {
        title: 'Rizado Definido',
        description: 'Tratamiento de hidratación profunda que resalta la belleza natural del cabello rizado con definición perfecta',
        category: 'Tratamiento',
        main: '/img/servicio_peluqueria3.jpg'
      }
    ]
  },
  {
    title: "Tratamientos Faciales",
    photos: [
      {
        title: 'Limpieza Profunda',
        description: 'Extracción de impurezas y purificación completa que devuelve la luminosidad natural a tu piel',
        category: 'Limpieza',
        main: '/img/servicio_peluqueria4.jpg'
      },
      {
        title: 'Hidratación Intensiva',
        description: 'Mascarilla con ácido hialurónico y vitaminas que restaura la elasticidad y suavidad de la piel',
        category: 'Hidratación',
        main: '/img/servicio_unas.jpg'
      }
    ]
  },
  {
    title: "Arte en Uñas",
    photos: [
      {
        title: 'Francés Moderno',
        description: 'Estilo clásico reinventado con un toque contemporáneo que combina elegancia y modernidad',
        category: 'Clásico',
        main: '/img/servicio_unas1.jpg'
      },
      {
        title: 'Arte Floral',
        description: 'Diseños delicados inspirados en la naturaleza que transforman tus uñas en pequeñas obras de arte',
        category: 'Artístico',
        main: '/img/servicio_unas2.jpg'
      }
    ]
  },
  {
    title: "Maquillaje Profesional",
    photos: [
      {
        title: 'Look Natural Día',
        description: 'Maquillaje suave y luminoso que realza tu belleza natural con técnicas profesionales impecables',
        category: 'Diario',
        main: '/img/servicio_unas3.jpg'
      },
      {
        title: 'Glamour Nocturno',
        description: 'Maquillaje sofisticado con smokey eyes y labios definidos perfecto para eventos especiales',
        category: 'Noche',
        main: '/img/servicio_peluqueria.jpg'
      }
    ]
  }
]

const timelineMilestones = [
  {
    year: '2021',
    title: 'Nuestros Inicios',
    description: 'Todo comenzó con un sueño: crear un espacio donde cada mujer pudiera descubrir su mejor versión. Abrimos nuestras puertas con servicios básicos pero con una gran pasión por la belleza.',
    image: '/img/servicio_peluqueria2.jpg'
  },
  {
    year: '2022',
    title: 'Expansión de Servicios',
    description: 'Incorporamos tratamientos faciales avanzados y técnicas de colorimetría internacional. Nuestro equipo creció y nos especializamos en transformaciones completas.',
    image: '/img/servicio_unas.jpg'
  },
  {
    year: '2023',
    title: 'Reconocimiento',
    description: 'Fuimos reconocidas como uno de los salones más innovadores de la ciudad. Más de 500 clientas han confiado en nosotras para sus transformaciones.',
    image: '/img/servicio_peluqueria3.jpg'
  },
  {
    year: '2024',
    title: 'Innovación Continua',
    description: 'Implementamos las últimas tecnologías en belleza y sostenibilidad. Cada día seguimos evolucionando para ofrecerte la mejor experiencia.',
    image: '/img/servicio_peluqueria4.jpg'
  }
]

// Computed properties
const allPhotos = computed(() => {
  const photos = []
  let photoIndex = 0
  
  photoSections.forEach((section, sectionIndex) => {
    section.photos.forEach((photo, photoIndexInSection) => {
      photos.push({
        ...photo,
        sectionTitle: section.title,
        sectionNumber: sectionIndex + 1,
        isFirstInSection: photoIndexInSection === 0,
        globalIndex: photoIndex++
      })
    })
  })
  
  return photos
})

const totalSections = computed(() => 1 + allPhotos.value.length + timelineMilestones.length + 1)

const progressPercentage = computed(() => {
  const currentIndex = currentPhotoIndex.value + 2 // +2 because intro is -1
  return Math.max(0, Math.min(100, (currentIndex / totalSections.value) * 100))
})

const currentSection = computed(() => {
  if (currentPhotoIndex.value === -1) {
    return { title: 'Introducción' }
  }
  
  if (currentPhotoIndex.value >= 0 && currentPhotoIndex.value < allPhotos.value.length) {
    const photo = allPhotos.value[currentPhotoIndex.value]
    return { title: photo.sectionTitle }
  }
  
  if (showTimeline.value) {
    return { title: 'Nuestra Evolución' }
  }
  
  if (showCTA.value) {
    return { title: 'Reservar Cita' }
  }
  
  return { title: 'Galería' }
})

const showTimeline = computed(() => {
  return currentPhotoIndex.value >= allPhotos.value.length && 
         currentPhotoIndex.value < allPhotos.value.length + timelineMilestones.length
})

const showCTA = computed(() => {
  return currentPhotoIndex.value >= allPhotos.value.length + timelineMilestones.length
})

const currentTimelineItem = computed(() => {
  if (showTimeline.value) {
    const timelineIndex = currentPhotoIndex.value - allPhotos.value.length
    return timelineMilestones[timelineIndex] || timelineMilestones[0]
  }
  return timelineMilestones[currentTimelineIndex.value]
})

// Methods
const setImageRef = (el, index) => {
  imageRefs.value[index] = el
}

const setTimelineItem = (index) => {
  currentTimelineIndex.value = index
  currentPhotoIndex.value = allPhotos.value.length + index
}

const initThreeJS = () => {
  if (!canvasRef.value) return

  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
  renderer = new THREE.WebGLRenderer({ canvas: canvasRef.value, alpha: true })
  clock = new THREE.Clock()

  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  // Create particles
  const particlesGeometry = new THREE.BufferGeometry()
  const particlesCount = 200
  const posArray = new Float32Array(particlesCount * 3)

  for (let i = 0; i < particlesCount * 3; i++) {
    posArray[i] = (Math.random() - 0.5) * 30
  }

  particlesGeometry.setAttribute('position', new THREE.BufferAttribute(posArray, 3))

  const particlesMaterial = new THREE.PointsMaterial({
    size: 0.003,
    color: '#FFB3C6',
    transparent: true,
    opacity: 0.5
  })

  particles = new THREE.Points(particlesGeometry, particlesMaterial)
  scene.add(particles)

  camera.position.z = 10

  const animate = () => {
    requestAnimationFrame(animate)

    const elapsedTime = clock.getElapsedTime()
    
    if (particles) {
      particles.rotation.y = elapsedTime * 0.01
      particles.rotation.x = elapsedTime * 0.005
    }

    renderer.render(scene, camera)
  }

  animate()
}

const initScrollAnimations = () => {
  if (!process.client) return

  const sections = document.querySelectorAll('section[data-photo], section[data-timeline]')
  const allSections = Array.from(document.querySelectorAll('section'))

  // Set up scroll triggers for each section
  allSections.forEach((section, index) => {
    const sectionIndex = index - 1 // -1 because first section is intro
    
    ScrollTrigger.create({
      trigger: section,
      start: "top 50%",
      end: "bottom 50%",
      onEnter: () => {
        if (index === 0) {
          // Intro section
          currentPhotoIndex.value = -1
        } else if (section.hasAttribute('data-photo')) {
          // Photo section
          const photoIndex = parseInt(section.getAttribute('data-photo'))
          currentPhotoIndex.value = photoIndex
        } else if (section.hasAttribute('data-timeline')) {
          // Timeline section
          const timelineIndex = parseInt(section.getAttribute('data-timeline'))
          currentPhotoIndex.value = allPhotos.value.length + timelineIndex
          currentTimelineIndex.value = timelineIndex
        } else if (index === allSections.length - 1) {
          // CTA section
          currentPhotoIndex.value = allPhotos.value.length + timelineMilestones.length
        }
      },
      onEnterBack: () => {
        if (index === 0) {
          currentPhotoIndex.value = -1
        } else if (section.hasAttribute('data-photo')) {
          const photoIndex = parseInt(section.getAttribute('data-photo'))
          currentPhotoIndex.value = photoIndex
        } else if (section.hasAttribute('data-timeline')) {
          const timelineIndex = parseInt(section.getAttribute('data-timeline'))
          currentPhotoIndex.value = allPhotos.value.length + timelineIndex
          currentTimelineIndex.value = timelineIndex
        } else if (index === allSections.length - 1) {
          currentPhotoIndex.value = allPhotos.value.length + timelineMilestones.length
        }
      }
    })
  })

  // Canvas opacity control
  ScrollTrigger.create({
    trigger: document.body,
    start: "top top",
    end: "bottom bottom",
    onUpdate: self => {
      canvasOpacity.value = 0.5 - (self.progress * 0.3)
    }
  })
}

const handleResize = () => {
  if (camera && renderer) {
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize(window.innerWidth, window.innerHeight)
  }
  
  ScrollTrigger.refresh()
}

onMounted(async () => {
  if (process.client) {
    await nextTick()
    
    initThreeJS()
    
    // Wait for DOM to be ready
    setTimeout(() => {
      initScrollAnimations()
    }, 1000)
    
    window.addEventListener('resize', handleResize)
  }
})

onUnmounted(() => {
  if (process.client) {
    window.removeEventListener('resize', handleResize)
    ScrollTrigger.getAll().forEach(trigger => trigger.kill())
    
    if (renderer) {
      renderer.dispose()
    }
  }
})
</script>

<style scoped>
/* Smooth scrolling */
html {
  scroll-behavior: smooth;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 6px;
}

::-webkit-scrollbar-track {
  background: transparent;
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(to bottom, var(--pink-medium, #FFB3C6), var(--coral, #FF9A8B));
  border-radius: 3px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(to bottom, var(--pink-dark, #FF8FAB), var(--coral, #FF9A8B));
}

/* Three.js canvas background */
canvas {
  background: linear-gradient(135deg, 
    var(--cream, #FFFEF7) 0%, 
    var(--pink-pastel, #FFE5EC) 30%, 
    var(--champagne, #F7E7CE) 100%
  );
}

/* Smooth transitions for all elements */
* {
  transition-property: transform, opacity, background-color, border-color, box-shadow, scale;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

/* Hide scrollbar on mobile for cleaner look */
@media (max-width: 768px) {
  html {
    scrollbar-width: none;
    -ms-overflow-style: none;
  }
  
  html::-webkit-scrollbar {
    display: none;
  }
  
  /* Smaller text on mobile */
  .text-6xl {
    font-size: 3rem;
  }
  
  .text-8xl {
    font-size: 4rem;
  }
}
</style>