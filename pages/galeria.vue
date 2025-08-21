<template>
  <div class="gallery-page">
    <!-- Hero Section -->
    <section class="hero-gallery relative h-screen flex items-center justify-center overflow-hidden">
      <div class="absolute inset-0 bg-gradient-to-br from-pink-600/20 via-orange-500/10 to-purple-600/20"></div>
      
      <!-- Background Image with Parallax -->
      <div 
        class="absolute inset-0 bg-cover bg-center transform"
        :style="{ transform: `translateY(${scrollY * 0.5}px)` }"
        style="background-image: url('https://images.unsplash.com/photo-1560066984-138dadb4c035?w=1920&h=1080&fit=crop&crop=center')"
      ></div>
      
      <!-- Content -->
      <div class="relative z-10 text-center text-white">
        <h1 
          class="text-7xl lg:text-9xl font-bold mb-6 tracking-tight"
          :class="{ 'animate-title': isVisible.hero }"
        >
          <span class="bg-gradient-to-r from-white via-pink-100 to-orange-100 bg-clip-text text-transparent">
            Galería
          </span>
        </h1>
        <p 
          class="text-2xl lg:text-3xl mb-8 opacity-90"
          :class="{ 'animate-subtitle': isVisible.hero }"
        >
          Nuestros Trabajos en Acción
        </p>
        <div 
          class="animate-bounce-custom"
          :class="{ 'animate-arrow': isVisible.hero }"
        >
          <div class="w-8 h-8 border-2 border-white transform rotate-45 translate-x-1"></div>
        </div>
      </div>
    </section>

    <!-- Gallery Sections -->
    <div class="gallery-content">
      
      <!-- Transformaciones Scroll Section -->
      <section class="scroll-section min-h-screen flex items-center justify-center py-20">
        <div class="max-w-7xl mx-auto px-6">
          <div 
            class="text-center mb-16"
            :class="{ 'animate-fade-in-up': isVisible.transformaciones }"
          >
            <h2 class="text-6xl font-bold mb-6 bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Transformaciones
            </h2>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto">
              Cada cliente es una obra de arte única
            </p>
          </div>

          <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            <div 
              v-for="(item, index) in galleryItems.transformaciones"
              :key="index"
              class="gallery-item"
              :class="{ 
                'animate-slide-in-left': isVisible.transformaciones && index % 2 === 0,
                'animate-slide-in-right': isVisible.transformaciones && index % 2 === 1
              }"
              :style="{ animationDelay: `${index * 200}ms` }"
              @click="openLightbox(item, 'transformaciones', index)"
            >
              <div class="relative overflow-hidden rounded-3xl group cursor-pointer">
                <img 
                  :src="item.image" 
                  :alt="item.title"
                  class="w-full h-80 object-cover transition-transform duration-700 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
                <div class="absolute bottom-0 left-0 right-0 p-6 text-white transform translate-y-full group-hover:translate-y-0 transition-transform duration-500">
                  <h3 class="text-xl font-bold mb-2">{{ item.title }}</h3>
                  <p class="text-sm opacity-90">{{ item.description }}</p>
                </div>
                <!-- Zoom Icon -->
                <div class="absolute top-4 right-4 w-10 h-10 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                  <span class="text-white text-lg">🔍</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Servicios Scroll Section -->
      <section class="scroll-section min-h-screen flex items-center justify-center py-20 bg-gradient-to-br from-pink-50/30 to-orange-50/20">
        <div class="max-w-7xl mx-auto px-6">
          <div 
            class="text-center mb-16"
            :class="{ 'animate-zoom-in': isVisible.servicios }"
          >
            <h2 class="text-6xl font-bold mb-6 bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              En Acción
            </h2>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto">
              Mira nuestros servicios siendo realizados
            </p>
          </div>

          <div class="grid md:grid-cols-2 gap-12 items-center">
            <div 
              class="space-y-8"
              :class="{ 'animate-slide-in-left': isVisible.servicios }"
            >
              <div 
                v-for="(item, index) in galleryItems.servicios"
                :key="index"
                class="service-item flex items-center space-x-4 p-6 bg-white rounded-2xl shadow-lg hover:shadow-xl transition-all duration-500 cursor-pointer"
                :style="{ animationDelay: `${index * 150}ms` }"
                @click="openLightbox(item, 'servicios', index)"
              >
                <div class="w-16 h-16 bg-gradient-to-br from-pink-500 to-orange-500 rounded-2xl flex items-center justify-center text-2xl text-white">
                  {{ item.icon }}
                </div>
                <div class="flex-1">
                  <h3 class="text-lg font-bold text-gray-800">{{ item.title }}</h3>
                  <p class="text-gray-600">{{ item.description }}</p>
                </div>
              </div>
            </div>

            <div 
              class="relative"
              :class="{ 'animate-slide-in-right': isVisible.servicios }"
            >
              <div class="masonry-grid">
                <div 
                  v-for="(item, index) in galleryItems.servicios"
                  :key="index"
                  class="masonry-item group cursor-pointer"
                  :class="{ 'animate-fade-in': isVisible.servicios }"
                  :style="{ animationDelay: `${index * 100}ms` }"
                  @click="openLightbox(item, 'servicios', index)"
                >
                  <img 
                    :src="item.image" 
                    :alt="item.title"
                    class="w-full h-full object-cover rounded-2xl transition-transform duration-700 group-hover:scale-105"
                  />
                  <div class="absolute inset-0 bg-black/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-2xl"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Productos Showcase -->
      <section class="scroll-section min-h-screen flex items-center justify-center py-20">
        <div class="max-w-7xl mx-auto px-6">
          <div 
            class="text-center mb-16"
            :class="{ 'animate-fade-in-up': isVisible.productos }"
          >
            <h2 class="text-6xl font-bold mb-6 bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Productos Premium
            </h2>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto">
              Los mejores productos para tu belleza
            </p>
          </div>

          <div class="product-showcase">
            <div 
              v-for="(item, index) in galleryItems.productos"
              :key="index"
              class="product-card group cursor-pointer"
              :class="{ 
                'animate-scale-in': isVisible.productos,
                'animate-delay-1': index === 1,
                'animate-delay-2': index === 2,
                'animate-delay-3': index === 3
              }"
              @click="openLightbox(item, 'productos', index)"
            >
              <div class="relative overflow-hidden rounded-3xl bg-white shadow-xl">
                <div class="aspect-square overflow-hidden">
                  <img 
                    :src="item.image" 
                    :alt="item.title"
                    class="w-full h-full object-cover transition-all duration-700 group-hover:scale-110 group-hover:rotate-2"
                  />
                </div>
                <div class="p-6">
                  <div class="flex items-center justify-between mb-2">
                    <span class="text-xs font-semibold uppercase tracking-wider text-pink-500 bg-pink-50 px-3 py-1 rounded-full">
                      {{ item.category }}
                    </span>
                    <span class="text-2xl">{{ item.icon }}</span>
                  </div>
                  <h3 class="text-lg font-bold mb-2">{{ item.title }}</h3>
                  <p class="text-gray-600 text-sm mb-4">{{ item.description }}</p>
                  <div class="flex items-center justify-between">
                    <span class="text-2xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
                      {{ item.price }}
                    </span>
                    <button class="p-2 bg-gradient-to-r from-pink-500 to-orange-500 text-white rounded-full hover:shadow-lg transform hover:scale-110 transition-all duration-300">
                      🛒
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Ambiente del Salón -->
      <section class="scroll-section min-h-screen flex items-center justify-center py-20 bg-gradient-to-br from-purple-50/30 to-pink-50/20">
        <div class="max-w-7xl mx-auto px-6">
          <div 
            class="text-center mb-16"
            :class="{ 'animate-fade-in-up': isVisible.ambiente }"
          >
            <h2 class="text-6xl font-bold mb-6 bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Nuestro Ambiente
            </h2>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto">
              Un espacio diseñado para tu relajación y belleza
            </p>
          </div>

          <div class="ambiente-grid">
            <div 
              v-for="(item, index) in galleryItems.ambiente"
              :key="index"
              class="ambiente-item group cursor-pointer"
              :class="{ 'animate-reveal': isVisible.ambiente }"
              :style="{ animationDelay: `${index * 300}ms` }"
              @click="openLightbox(item, 'ambiente', index)"
            >
              <div class="relative overflow-hidden rounded-3xl">
                <img 
                  :src="item.image" 
                  :alt="item.title"
                  class="w-full h-full object-cover transition-all duration-1000 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
                <div class="absolute bottom-0 left-0 right-0 p-6 text-white transform translate-y-full group-hover:translate-y-0 transition-transform duration-500">
                  <h3 class="text-xl font-bold mb-2">{{ item.title }}</h3>
                  <p class="text-sm opacity-90">{{ item.description }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>

    <!-- Lightbox Modal -->
    <div 
      v-if="lightbox.isOpen"
      class="fixed inset-0 z-50 flex items-center justify-center bg-black/90 backdrop-blur-sm"
      @click="closeLightbox"
    >
      <div class="relative max-w-4xl max-h-[90vh] m-4">
        <button 
          @click="closeLightbox"
          class="absolute -top-12 right-0 text-white text-2xl w-10 h-10 flex items-center justify-center rounded-full bg-white/20 hover:bg-white/30 transition-colors"
        >
          ✕
        </button>
        
        <div class="bg-white rounded-3xl overflow-hidden shadow-2xl max-h-[90vh] overflow-y-auto">
          <div class="aspect-video">
            <img 
              :src="lightbox.item?.image" 
              :alt="lightbox.item?.title"
              class="w-full h-full object-cover"
            />
          </div>
          <div class="p-8">
            <h3 class="text-3xl font-bold mb-4 bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              {{ lightbox.item?.title }}
            </h3>
            <p class="text-gray-600 text-lg mb-6">{{ lightbox.item?.description }}</p>
            
            <!-- Navigation -->
            <div class="flex justify-between items-center">
              <button 
                @click="previousImage"
                class="flex items-center space-x-2 px-6 py-3 bg-gradient-to-r from-pink-500 to-orange-500 text-white rounded-full hover:shadow-lg transition-all"
              >
                <span>←</span>
                <span>Anterior</span>
              </button>
              
              <span class="text-gray-500">
                {{ lightbox.currentIndex + 1 }} / {{ currentGalleryItems.length }}
              </span>
              
              <button 
                @click="nextImage"
                class="flex items-center space-x-2 px-6 py-3 bg-gradient-to-r from-pink-500 to-orange-500 text-white rounded-full hover:shadow-lg transition-all"
              >
                <span>Siguiente</span>
                <span>→</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
// SEO
useHead({
  title: 'Galería - Toda Bonita',
  meta: [
    { name: 'description', content: 'Explora nuestra galería de transformaciones, servicios y productos. Descubre el trabajo excepcional de nuestro salón de belleza.' },
    { name: 'keywords', content: 'galería, transformaciones, antes y después, servicios de belleza, productos premium' }
  ]
})

// Reactive data
const scrollY = ref(0)
const isVisible = ref({
  hero: false,
  transformaciones: false,
  servicios: false,
  productos: false,
  ambiente: false
})

const lightbox = ref({
  isOpen: false,
  item: null,
  currentIndex: 0,
  gallery: ''
})

// Gallery data
const galleryItems = {
  transformaciones: [
    {
      title: 'Cambio de Look Completo',
      description: 'Transformación radical de cabello largo y oscuro a un moderno bob rubio con mechas platinadas',
      image: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=800&h=600&fit=crop&crop=face'
    },
    {
      title: 'Rejuvenecimiento Facial',
      description: 'Tratamiento completo de limpieza profunda y hidratación con resultados visibles inmediatos',
      image: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=800&h=600&fit=crop&crop=face'
    },
    {
      title: 'Extensiones de Pestañas Dramáticas',
      description: 'De pestañas naturales a un look de volumen dramático que realza completamente la mirada',
      image: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&h=600&fit=crop&crop=face'
    },
    {
      title: 'Color Fantasía',
      description: 'Coloración vibrante con tonos rosas y morados para un look único y personalizado',
      image: 'https://images.unsplash.com/photo-1594736797933-d0401ba2fe65?w=800&h=600&fit=crop&crop=face'
    },
    {
      title: 'Maquillaje de Novia',
      description: 'Look nupcial elegante con técnicas de contouring y maquillaje de larga duración',
      image: 'https://images.unsplash.com/photo-1583900985737-6d0495555783?w=800&h=600&fit=crop&crop=face'
    },
    {
      title: 'Tratamiento Capilar',
      description: 'Reparación intensiva de cabello dañado con productos profesionales de alta gama',
      image: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=800&h=600&fit=crop&crop=face'
    }
  ],
  servicios: [
    {
      title: 'Corte y Peinado',
      description: 'Técnicas profesionales de corte',
      icon: '✂️',
      image: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=600&h=400&fit=crop'
    },
    {
      title: 'Coloración',
      description: 'Colores vibrantes y naturales',
      icon: '🎨',
      image: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=600&h=400&fit=crop'
    },
    {
      title: 'Extensiones de Pestañas',
      description: 'Volumen y longitud perfectos',
      icon: '👁️',
      image: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=600&h=400&fit=crop'
    },
    {
      title: 'Manicura Premium',
      description: 'Diseños únicos y duraderos',
      icon: '💅',
      image: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=600&h=400&fit=crop'
    },
    {
      title: 'Limpieza Facial',
      description: 'Tratamientos personalizados',
      icon: '✨',
      image: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=600&h=400&fit=crop'
    },
    {
      title: 'Masajes Relajantes',
      description: 'Terapias de relajación',
      icon: '🌸',
      image: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=600&h=400&fit=crop'
    }
  ],
  productos: [
    {
      title: 'Serum Capilar Premium',
      description: 'Reparación intensiva para cabello dañado',
      category: 'Cabello',
      icon: '💧',
      price: '$65',
      image: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop'
    },
    {
      title: 'Mascarilla Rejuvenecedora',
      description: 'Hidratación profunda y anti-edad',
      category: 'Skincare',
      icon: '✨',
      price: '$45',
      image: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop'
    },
    {
      title: 'Aceite de Argán Orgánico',
      description: 'Nutrición natural para cabello y piel',
      category: 'Natural',
      icon: '🍃',
      price: '$55',
      image: 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=400&h=400&fit=crop'
    },
    {
      title: 'Kit Anti-Edad Completo',
      description: 'Sistema completo de cuidado facial',
      category: 'Skincare',
      icon: '🎁',
      price: '$120',
      image: 'https://images.unsplash.com/photo-1570194065650-d99fb4bedf0a?w=400&h=400&fit=crop'
    }
  ],
  ambiente: [
    {
      title: 'Recepción Elegante',
      description: 'Espacio acogedor donde comienza tu experiencia de belleza',
      image: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=800&h=600&fit=crop'
    },
    {
      title: 'Estaciones de Peluquería',
      description: 'Equipamiento profesional de última generación',
      image: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=800&h=600&fit=crop'
    },
    {
      title: 'Área de Relajación',
      description: 'Zona tranquila para tratamientos faciales y masajes',
      image: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=800&h=600&fit=crop'
    },
    {
      title: 'Sala VIP',
      description: 'Espacio exclusivo para tratamientos premium',
      image: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=800&h=600&fit=crop'
    }
  ]
}

// Computed
const currentGalleryItems = computed(() => {
  return galleryItems[lightbox.value.gallery] || []
})

// Methods
const openLightbox = (item, gallery, index) => {
  lightbox.value = {
    isOpen: true,
    item,
    currentIndex: index,
    gallery
  }
  document.body.style.overflow = 'hidden'
}

const closeLightbox = () => {
  lightbox.value.isOpen = false
  document.body.style.overflow = 'auto'
}

const nextImage = () => {
  const items = currentGalleryItems.value
  lightbox.value.currentIndex = (lightbox.value.currentIndex + 1) % items.length
  lightbox.value.item = items[lightbox.value.currentIndex]
}

const previousImage = () => {
  const items = currentGalleryItems.value
  lightbox.value.currentIndex = lightbox.value.currentIndex === 0 
    ? items.length - 1 
    : lightbox.value.currentIndex - 1
  lightbox.value.item = items[lightbox.value.currentIndex]
}

// Scroll handling
const handleScroll = () => {
  scrollY.value = window.scrollY
}

// Intersection Observer for animations
const setupIntersectionObserver = () => {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        const target = entry.target
        if (target.id === 'hero') isVisible.value.hero = true
        if (target.classList.contains('transformaciones-section')) isVisible.value.transformaciones = true
        if (target.classList.contains('servicios-section')) isVisible.value.servicios = true
        if (target.classList.contains('productos-section')) isVisible.value.productos = true
        if (target.classList.contains('ambiente-section')) isVisible.value.ambiente = true
      }
    })
  }, { threshold: 0.3 })

  // Observe sections when they're available
  nextTick(() => {
    const sections = document.querySelectorAll('.scroll-section')
    sections.forEach((section, index) => {
      section.classList.add(['transformaciones-section', 'servicios-section', 'productos-section', 'ambiente-section'][index])
      observer.observe(section)
    })
  })
}

// Lifecycle
onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  setupIntersectionObserver()
  
  // Trigger hero animation
  setTimeout(() => {
    isVisible.value.hero = true
  }, 500)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  document.body.style.overflow = 'auto'
})

// Keyboard navigation
onMounted(() => {
  const handleKeydown = (e) => {
    if (!lightbox.value.isOpen) return
    
    if (e.key === 'Escape') closeLightbox()
    if (e.key === 'ArrowLeft') previousImage()
    if (e.key === 'ArrowRight') nextImage()
  }
  
  window.addEventListener('keydown', handleKeydown)
  
  onUnmounted(() => {
    window.removeEventListener('keydown', handleKeydown)
  })
})
</script>

<style scoped>
/* Custom Animations */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(50px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-100px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes slideInRight {
  from {
    opacity: 0;
    transform: translateX(100px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes zoomIn {
  from {
    opacity: 0;
    transform: scale(0.8);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

@keyframes scaleIn {
  from {
    opacity: 0;
    transform: scale(0.9) rotateY(15deg);
  }
  to {
    opacity: 1;
    transform: scale(1) rotateY(0deg);
  }
}

@keyframes reveal {
  from {
    opacity: 0;
    transform: translateY(30px) rotateX(15deg);
  }
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0deg);
  }
}

@keyframes bounceCustom {
  0%, 20%, 50%, 80%, 100% {
    transform: translateY(0);
  }
  40% {
    transform: translateY(-30px);
  }
  60% {
    transform: translateY(-15px);
  }
}

/* Animation Classes */
.animate-title {
  animation: fadeInUp 1.2s ease-out;
}

.animate-subtitle {
  animation: fadeInUp 1.2s ease-out 0.3s both;
}

.animate-arrow {
  animation: bounceCustom 2s infinite 1s;
}

.animate-fade-in-up {
  animation: fadeInUp 0.8s ease-out;
}

.animate-slide-in-left {
  animation: slideInLeft 0.8s ease-out;
}

.animate-slide-in-right {
  animation: slideInRight 0.8s ease-out;
}

.animate-zoom-in {
  animation: zoomIn 0.8s ease-out;
}

.animate-scale-in {
  animation: scaleIn 0.8s ease-out;
}

.animate-reveal {
  animation: reveal 1s ease-out;
}

.animate-fade-in {
  animation: fadeInUp 0.6s ease-out;
}

.animate-delay-1 { animation-delay: 0.2s; animation-fill-mode: both; }
.animate-delay-2 { animation-delay: 0.4s; animation-fill-mode: both; }
.animate-delay-3 { animation-delay: 0.6s; animation-fill-mode: both; }

/* Layout Styles */
.hero-gallery {
  background: linear-gradient(135deg, #ff6b9d 0%, #ff8a5c 50%, #c471ed 100%);
}

.masonry-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
  grid-auto-rows: minmax(200px, auto);
}

.masonry-item {
  position: relative;
  overflow: hidden;
  border-radius: 1rem;
}

.masonry-item:nth-child(odd) {
  grid-row: span 2;
}

.product-showcase {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.ambiente-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.ambiente-item {
  height: 400px;
  position: relative;
}

.ambiente-item:nth-child(even) {
  margin-top: 2rem;
}

/* Responsive */
@media (max-width: 768px) {
  .masonry-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .product-showcase {
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1rem;
  }
  
  .ambiente-grid {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .ambiente-item:nth-child(even) {
    margin-top: 0;
  }
}

/* Scroll Behavior */
.gallery-page {
  scroll-behavior: smooth;
}

/* Loading Animation */
.gallery-item {
  opacity: 0;
  transform: translateY(30px);
}

.gallery-item.animate-slide-in-left,
.gallery-item.animate-slide-in-right {
  opacity: 1;
  transform: translateY(0);
}
</style>