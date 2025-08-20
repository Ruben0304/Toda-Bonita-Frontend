<template>
  <div class="min-h-screen">
    <!-- Three.js Background -->
    <ThreeBackground />
    
    <!-- Hero Section con animaciones sutiles -->
    <section id="inicio" class="min-h-screen relative overflow-hidden">
      <HeroAnimations>
        <!-- Título principal con animación sutil -->
        <template #text-reveal>
          <h1 
            class="text-6xl lg:text-8xl font-bold mb-4 tracking-tight font-playfair"
            data-aos="fade-up"
            data-aos-duration="800"
          >
            Toda Bonita
          </h1>
        </template>
        
        <!-- Subtítulo -->
        <template #subtitle>
          La etapa de ser nuestra clienta...
        </template>
        
        <!-- Botones -->
        <template #buttons>
          <button class="group px-8 py-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-bold rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300 text-lg relative overflow-hidden">
            <span class="relative z-10 flex items-center space-x-2">
              <Icon name="lucide:calendar-heart" class="w-5 h-5" />
              <span>Reservar Mi Transformación</span>
              <Icon name="lucide:arrow-right" class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </span>
          </button>
          
          <button 
            @click="scrollToSection('servicios')"
            class="group px-8 py-4 bg-white/90 backdrop-blur-sm border border-pink-300 text-pink-600 font-bold rounded-full shadow-md hover:shadow-lg transform hover:scale-105 transition-all duration-300 text-lg hover:bg-pink-50 relative overflow-hidden"
          >
            <span class="relative z-10 flex items-center space-x-2">
              <Icon name="lucide:sparkles" class="w-4 h-4" />
              <span>Descubrir Servicios</span>
              <Icon name="lucide:chevron-down" class="w-4 h-4 group-hover:translate-y-1 transition-transform" />
            </span>
          </button>
        </template>
      </HeroAnimations>
      
      <!-- Estadísticas/Features destacadas -->
      <div 
        class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-3xl mx-auto"
        data-aos="fade-up"
        data-aos-delay="1000"
        data-aos-duration="1000"
      >
        <div class="text-center p-4 rounded-2xl bg-white/20 backdrop-blur-sm border border-white/30">
          <div class="text-3xl font-bold text-pink-600 mb-2">500+</div>
          <div class="text-sm text-gray-600 font-medium">Clientas Felices</div>
        </div>
        <div class="text-center p-4 rounded-2xl bg-white/20 backdrop-blur-sm border border-white/30">
          <div class="text-3xl font-bold text-pink-600 mb-2">5★</div>
          <div class="text-sm text-gray-600 font-medium">Calificación</div>
        </div>
        <div class="text-center p-4 rounded-2xl bg-white/20 backdrop-blur-sm border border-white/30">
          <div class="text-3xl font-bold text-pink-600 mb-2">3+</div>
          <div class="text-sm text-gray-600 font-medium">Años de Experiencia</div>
        </div>
      </div>

      <!-- Indicador de scroll mejorado -->
      <div 
        class="absolute bottom-8 left-1/2 transform -translate-x-1/2"
        data-aos="fade-in"
        data-aos-delay="1200"
      >
        <div class="flex flex-col items-center space-y-2 animate-bounce">
          <div class="text-sm text-pink-500 font-medium">Desliza para explorar</div>
          <div class="w-8 h-8 border-2 border-pink-400 rounded-full flex items-center justify-center">
            <Icon name="lucide:chevron-down" class="w-4 h-4 text-pink-500" />
          </div>
        </div>
      </div>

      <!-- Overlay sutil para legibilidad -->
      <div class="absolute inset-0 bg-white/10 backdrop-blur-[1px]"></div>
    </section>

    <!-- Transformaciones Section -->
    <section id="transformaciones" class="py-24 px-6 relative bg-gradient-to-br from-white to-pink-50/30">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
          <h2 
            class="text-5xl lg:text-6xl font-bold mb-6"
            data-aos="fade-up"
            data-aos-duration="1000"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Transformaciones Mágicas
            </span>
          </h2>
          <p 
            class="text-xl text-gray-600 max-w-2xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="1000"
          >
            Mira los increíbles cambios de nuestras clientas
          </p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div 
            v-for="(trans, index) in transformaciones"
            :key="index"
            class="group bg-white rounded-3xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2"
            data-aos="zoom-in"
            :data-aos-delay="index * 200"
            data-aos-duration="800"
          >
            <div class="relative">
              <div class="flex h-64">
                <div class="w-1/2 relative overflow-hidden">
                  <div class="absolute top-3 left-3 bg-gray-800 text-white px-3 py-1 rounded-full text-sm font-semibold z-10">
                    Antes
                  </div>
                  <img 
                    :src="trans.antes" 
                    alt="Antes"
                    class="w-full h-full object-cover filter grayscale group-hover:grayscale-0 transition-all duration-500"
                  />
                </div>
                <div class="w-1/2 relative overflow-hidden">
                  <div class="absolute top-3 right-3 bg-green-500 text-white px-3 py-1 rounded-full text-sm font-semibold z-10">
                    Después
                  </div>
                  <img 
                    :src="trans.despues" 
                    alt="Después"
                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                  />
                </div>
              </div>
              <div class="absolute inset-x-0 top-1/2 transform -translate-y-1/2 flex justify-center">
                <div class="bg-white rounded-full p-3 shadow-xl border-4 border-pink-100">
                  <div class="w-6 h-6 text-pink-500">→</div>
                </div>
              </div>
            </div>
            <div class="p-6">
              <h3 class="text-xl font-bold text-gray-800 mb-2">{{ trans.titulo }}</h3>
              <p class="text-gray-600">{{ trans.descripcion }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Servicios Section -->
    <section id="servicios" class="py-24 px-6 bg-gradient-to-br from-pink-50/30 to-orange-50/20">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
          <h2 
            class="text-5xl lg:text-6xl font-bold mb-6"
            data-aos="fade-up"
            data-aos-duration="1000"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Nuestros Servicios
            </span>
          </h2>
          <p 
            class="text-xl text-gray-600 max-w-2xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="1000"
          >
            Todo lo que necesitas para verte y sentirte increíble
          </p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div 
            v-for="(servicio, index) in servicios"
            :key="index"
            class="group bg-white rounded-3xl p-8 shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2 border border-pink-100/50"
            data-aos="flip-left"
            :data-aos-delay="index * 100"
            data-aos-duration="600"
          >
            <div class="w-16 h-16 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform duration-300">
              <div class="text-2xl">{{ servicio.icon }}</div>
            </div>
            <h3 class="text-xl font-bold mb-4 text-center text-gray-800">
              {{ servicio.titulo }}
            </h3>
            <ul class="space-y-3">
              <li 
                v-for="(sub, subIndex) in servicio.subservicios" 
                :key="subIndex" 
                class="text-sm flex items-center text-gray-600"
              >
                <div class="w-2 h-2 bg-green-400 rounded-full mr-3 flex-shrink-0"></div>
                {{ sub }}
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Productos Section -->
    <section id="productos" class="py-24 px-6 bg-gradient-to-br from-white to-purple-50/30">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
          <h2 
            class="text-5xl lg:text-6xl font-bold mb-6"
            data-aos="fade-up"
            data-aos-duration="1000"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Nuestros Productos
            </span>
          </h2>
          <p 
            class="text-xl text-gray-600 max-w-2xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="1000"
          >
            Los mejores productos para tu cuidado personal
          </p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div 
            v-for="(producto, index) in productos"
            :key="index"
            class="group bg-white rounded-3xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2"
            data-aos="fade-up"
            :data-aos-delay="index * 150"
            data-aos-duration="800"
          >
            <div class="h-48 overflow-hidden">
              <img 
                :src="producto.imagen" 
                :alt="producto.nombre"
                class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
              />
            </div>
            <div class="p-6">
              <div class="flex items-center justify-between mb-3">
                <span class="text-xs font-semibold uppercase tracking-wider text-pink-500 bg-pink-50 px-3 py-1 rounded-full">
                  {{ producto.categoria }}
                </span>
                <div class="text-lg">{{ producto.icon }}</div>
              </div>
              <h3 class="text-lg font-bold mb-3 text-gray-800">
                {{ producto.nombre }}
              </h3>
              <p class="text-sm mb-4 text-gray-600">
                {{ producto.descripcion }}
              </p>
              <div class="flex items-center justify-between">
                <span class="text-2xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
                  {{ producto.precio }}
                </span>
                <button 
                  @click="addToCart(producto)"
                  class="p-3 bg-gradient-to-r from-pink-500 to-orange-500 text-white rounded-full hover:shadow-lg transform hover:scale-110 transition-all duration-300"
                >
                  🛒
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Contacto Section -->
    <section id="contacto" class="py-24 px-6 bg-gradient-to-br from-pink-50/30 to-white">
      <div class="max-w-6xl mx-auto">
        <div class="text-center mb-16">
          <h2 
            class="text-5xl lg:text-6xl font-bold mb-6"
            data-aos="fade-up"
            data-aos-duration="1000"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Encuéntranos
            </span>
          </h2>
          <p 
            class="text-xl text-gray-600 max-w-2xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="1000"
          >
            Ven a visitarnos y empieza tu transformación
          </p>
        </div>

        <div class="grid md:grid-cols-2 gap-12">
          <div 
            class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50"
            data-aos="slide-right"
            data-aos-duration="800"
          >
            <h3 class="text-2xl font-bold mb-8 bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
              Información de Contacto
            </h3>
            
            <div class="space-y-6">
              <div class="flex items-center">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                  <div class="text-white text-lg">📍</div>
                </div>
                <div>
                  <p class="font-semibold text-gray-800">Dirección</p>
                  <p class="text-gray-600">Calle Belleza 123, Ciudad</p>
                </div>
              </div>
              
              <div class="flex items-center">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                  <div class="text-white text-lg">📞</div>
                </div>
                <div>
                  <p class="font-semibold text-gray-800">Teléfono</p>
                  <p class="text-gray-600">+1 234 567 8900</p>
                </div>
              </div>
              
              <div class="flex items-center">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                  <div class="text-white text-lg">✉️</div>
                </div>
                <div>
                  <p class="font-semibold text-gray-800">Email</p>
                  <p class="text-gray-600">hola@todabonita.com</p>
                </div>
              </div>
              
              <div class="flex items-center">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                  <div class="text-white text-lg">🕒</div>
                </div>
                <div>
                  <p class="font-semibold text-gray-800">Horario</p>
                  <p class="text-gray-600">Lun - Sab: 9:00 AM - 8:00 PM</p>
                  <p class="text-gray-600">Dom: 10:00 AM - 6:00 PM</p>
                </div>
              </div>
            </div>
          </div>

          <div 
            class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50"
            data-aos="slide-left"
            data-aos-duration="800"
          >
            <h3 class="text-2xl font-bold mb-8 bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
              Síguenos
            </h3>
            
            <div class="grid grid-cols-3 gap-4 mb-8">
              <button 
                @click="openSocial('instagram')"
                class="p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-110 group border border-pink-200/50"
              >
                <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center group-hover:scale-110 transition-transform mx-auto">
                  <div class="text-white">📷</div>
                </div>
              </button>
              <button 
                @click="openSocial('facebook')"
                class="p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-110 group border border-pink-200/50"
              >
                <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center group-hover:scale-110 transition-transform mx-auto">
                  <div class="text-white">📘</div>
                </div>
              </button>
              <button 
                @click="openSocial('tiktok')"
                class="p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-110 group border border-pink-200/50"
              >
                <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center group-hover:scale-110 transition-transform mx-auto">
                  <div class="text-white">🎵</div>
                </div>
              </button>
            </div>

            <div class="bg-gradient-to-r from-pink-100 to-orange-100 rounded-2xl p-6 border border-pink-200/50">
              <p class="text-center font-semibold text-gray-700 mb-4">
                ¿Lista para tu transformación?
              </p>
              <button 
                @click="bookAppointment"
                class="w-full py-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-bold rounded-2xl shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300"
              >
                Agenda Tu Cita Ahora
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
// SEO
useHead({
  title: 'Toda Bonita - Salón de Belleza',
  meta: [
    { name: 'description', content: 'Tu salón de belleza de confianza donde cada visita es una experiencia única. Especialistas en peluquería, manicura, extensiones de pestañas y más.' },
    { name: 'keywords', content: 'salón de belleza, peluquería, manicura, extensiones de pestañas, limpiezas faciales, masajes, tratamientos de belleza' },
    { property: 'og:title', content: 'Toda Bonita - Salón de Belleza' },
    { property: 'og:description', content: 'La etapa de ser nuestra clienta... ¡Te recomiendo no saltártela!' },
    { property: 'og:type', content: 'website' },
    { name: 'twitter:card', content: 'summary_large_image' }
  ]
})

// Datos
const transformaciones = [
  {
    titulo: 'Cambio de Look Completo',
    descripcion: 'De cabello largo y oscuro a un moderno bob rubio',
    antes: 'https://images.unsplash.com/photo-1494790108755-2616c78ff7db?w=400&h=300&fit=crop&crop=face',
    despues: 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=400&h=300&fit=crop&crop=face'
  },
  {
    titulo: 'Transformación Facial',
    descripcion: 'Tratamiento completo de rejuvenecimiento',
    antes: 'https://images.unsplash.com/photo-1596815064285-45ed8a9c13f4?w=400&h=300&fit=crop&crop=face',
    despues: 'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=400&h=300&fit=crop&crop=face'
  },
  {
    titulo: 'Extensiones de Pestañas',
    descripcion: 'De look natural a pestañas de volumen dramático',
    antes: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400&h=300&fit=crop&crop=face',
    despues: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=300&fit=crop&crop=face'
  }
]

const servicios = [
  {
    titulo: 'Peluquería',
    icon: '✂️',
    subservicios: ['Corte', 'Color', 'Peinados', 'Tratamientos capilares']
  },
  {
    titulo: 'Extensión de Pestañas',
    icon: '👁️',
    subservicios: ['Clásicas', 'Volumen', 'Lifting', 'Tinte']
  },
  {
    titulo: 'Manicura y Pedicura',
    icon: '💅',
    subservicios: ['Gel', 'Semipermanente', 'Diseños', 'Spa de manos']
  },
  {
    titulo: 'Limpiezas Faciales',
    icon: '✨',
    subservicios: ['Profunda', 'Hidratación', 'Exfoliación', 'Peeling']
  },
  {
    titulo: 'Depilaciones',
    icon: '⚡',
    subservicios: ['Cera', 'Láser', 'Hilo', 'Definitiva']
  },
  {
    titulo: 'Mascarillas de Belleza',
    icon: '💖',
    subservicios: ['Oro', 'Colágeno', 'Vitamina C', 'Ácido hialurónico']
  },
  {
    titulo: 'Masajes',
    icon: '🌸',
    subservicios: ['Relajante', 'Descontracturante', 'Piedras calientes', 'Aromaterapia']
  },
  {
    titulo: 'Fototerapia',
    icon: '☀️',
    subservicios: ['LED', 'Rejuvenecimiento', 'Acné', 'Manchas']
  }
]

const productos = [
  { 
    nombre: 'Serum Capilar Reparador', 
    precio: '$45', 
    categoria: 'Cabello',
    icon: '💧',
    descripcion: 'Repara y fortalece el cabello dañado',
    imagen: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Mascarilla Hidratante', 
    precio: '$38', 
    categoria: 'Skincare',
    icon: '✨',
    descripcion: 'Hidratación profunda para todo tipo de piel',
    imagen: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Aceite de Argán Premium', 
    precio: '$52', 
    categoria: 'Cabello',
    icon: '🍃',
    descripcion: 'Aceite natural para nutrición capilar',
    imagen: 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Crema Anti-edad', 
    precio: '$68', 
    categoria: 'Skincare',
    icon: '🕐',
    descripcion: 'Reduce líneas de expresión y arrugas',
    imagen: 'https://images.unsplash.com/photo-1570194065650-d99fb4bedf0a?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Protector Térmico', 
    precio: '$35', 
    categoria: 'Cabello',
    icon: '🛡️',
    descripcion: 'Protege el cabello del calor del secador',
    imagen: 'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Tónico Facial', 
    precio: '$28', 
    categoria: 'Skincare',
    icon: '🌊',
    descripcion: 'Equilibra y refresca la piel',
    imagen: 'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=400&h=300&fit=crop&crop=center'
  }
]

// Funciones
const scrollToSection = (sectionId) => {
  const element = document.getElementById(sectionId)
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' })
  }
}

const addToCart = (producto) => {
  alert(`${producto.nombre} agregado al carrito!`)
}

const openSocial = (platform) => {
  const urls = {
    instagram: 'https://instagram.com/todabonita',
    facebook: 'https://facebook.com/todabonita',
    tiktok: 'https://tiktok.com/@todabonita'
  }
  
  if (urls[platform]) {
    window.open(urls[platform], '_blank')
  }
}

const bookAppointment = () => {
  alert('¡Redirección a sistema de reservas!')
}
</script>