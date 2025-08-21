<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/10 to-orange-50/5">
    <!-- Navegación de regreso -->
    <section class="py-6 px-6">
      <div class="max-w-6xl mx-auto">
        <button 
          @click="$router.go(-1)"
          class="flex items-center space-x-2 text-pink-600 hover:text-pink-700 transition-colors duration-300"
        >
          <Icon name="lucide:arrow-left" class="w-5 h-5" />
          <span class="font-medium">Volver</span>
        </button>
      </div>
    </section>

    <!-- Servicio Principal -->
    <section class="py-8 px-6">
      <div class="max-w-6xl mx-auto">
        <div class="grid lg:grid-cols-2 gap-12 items-start">
          <!-- Imagen del servicio -->
          <div class="space-y-4" data-aos="fade-right">
            <div class="relative group">
              <div class="absolute inset-0 bg-gradient-to-r from-pink-500/20 to-orange-500/20 rounded-3xl blur-xl group-hover:blur-2xl transition-all duration-300 opacity-0 group-hover:opacity-100"></div>
              <div class="relative bg-white rounded-3xl overflow-hidden shadow-lg border border-pink-100/50">
                <img 
                  :src="servicio.imagen" 
                  :alt="servicio.nombre"
                  class="w-full h-96 lg:h-[500px] object-cover"
                />
                <!-- Badge de categoría -->
                <div class="absolute top-6 left-6">
                  <span class="text-sm font-semibold uppercase tracking-wider text-white bg-gradient-to-r from-pink-500/90 to-orange-500/90 backdrop-blur-sm px-3 py-2 rounded-full">
                    {{ servicio.categoria }}
                  </span>
                </div>
                <!-- Badge de duración -->
                <div class="absolute top-6 right-6">
                  <span class="text-sm font-semibold text-white bg-black/50 backdrop-blur-sm px-3 py-2 rounded-full">
                    {{ servicio.duracion }} min
                  </span>
                </div>
              </div>
            </div>
            <!-- Galería adicional -->
            <div class="grid grid-cols-3 gap-3">
              <div v-for="i in 3" :key="i" class="relative">
                <img 
                  :src="servicio.imagen" 
                  :alt="`${servicio.nombre} vista ${i}`"
                  class="w-full h-24 object-cover rounded-xl border border-pink-200/50 hover:border-pink-400 transition-colors cursor-pointer"
                />
              </div>
            </div>
          </div>

          <!-- Información del servicio -->
          <div class="space-y-6" data-aos="fade-left">
            <!-- Rating y reviews -->
            <div class="flex items-center space-x-4">
              <div class="flex text-yellow-400">
                <span v-for="i in 5" :key="i" class="text-lg">
                  {{ i <= servicio.rating ? '⭐' : '☆' }}
                </span>
              </div>
              <span class="text-gray-600">({{ servicio.reviews }} reseñas)</span>
              <!-- Tags -->
              <div class="flex space-x-2">
                <span v-if="servicio.popular" class="text-xs bg-purple-100 text-purple-600 px-2 py-1 rounded-full font-semibold">
                  Popular
                </span>
                <span v-if="servicio.nuevo" class="text-xs bg-blue-100 text-blue-600 px-2 py-1 rounded-full font-semibold">
                  Nuevo
                </span>
              </div>
            </div>

            <!-- Nombre y descripción -->
            <div>
              <h1 class="text-3xl lg:text-4xl font-bold text-gray-800 mb-4">
                {{ servicio.nombre }}
              </h1>
              <p class="text-lg text-gray-600 leading-relaxed">
                {{ servicio.descripcionCompleta || servicio.descripcion }}
              </p>
            </div>

            <!-- Precio y duración -->
            <div class="flex items-center space-x-6">
              <div>
                <span class="text-4xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
                  ${{ servicio.precio }}
                </span>
                <p class="text-sm text-gray-500">por sesión</p>
              </div>
              <div class="text-3xl">{{ servicio.icon }}</div>
              <div>
                <span class="text-2xl font-semibold text-gray-700">{{ servicio.duracion }} min</span>
                <p class="text-sm text-gray-500">duración aprox.</p>
              </div>
            </div>

            <!-- Disponibilidad -->
            <div class="flex items-center space-x-3">
              <span 
                :class="[
                  'px-3 py-1 rounded-full font-semibold text-sm',
                  servicio.disponible 
                    ? 'bg-green-100 text-green-600' 
                    : 'bg-red-100 text-red-600'
                ]"
              >
                {{ servicio.disponible ? 'Disponible' : 'No disponible' }}
              </span>
              <span class="text-sm text-gray-500">• Próxima cita disponible: {{ servicio.proximaCita }}</span>
            </div>

            <!-- Botones de acción -->
            <div class="space-y-4">
              <NuxtLink to="/reserva" class="block">
                <button 
                  :disabled="!servicio.disponible"
                  :class="[
                    'w-full py-4 rounded-2xl font-bold transition-all duration-300 transform hover:scale-105',
                    servicio.disponible
                      ? 'bg-gradient-to-r from-pink-500 to-orange-500 text-white hover:shadow-lg'
                      : 'bg-gray-200 text-gray-400 cursor-not-allowed'
                  ]"
                >
                  <span v-if="servicio.disponible" class="flex items-center justify-center space-x-2">
                    <Icon name="lucide:calendar-plus" class="w-5 h-5" />
                    <span>Reservar Cita</span>
                  </span>
                  <span v-else>No Disponible</span>
                </button>
              </NuxtLink>
              
              <div class="flex space-x-3">
                <button 
                  @click="addToFavorites"
                  class="flex-1 py-3 border-2 border-pink-300 text-pink-600 rounded-2xl hover:bg-pink-50 transition-all duration-300 hover:scale-105 font-semibold"
                >
                  <span class="flex items-center justify-center space-x-2">
                    <Icon name="lucide:heart" class="w-5 h-5" />
                    <span>Favoritos</span>
                  </span>
                </button>
                <button 
                  @click="shareService"
                  class="flex-1 py-3 border-2 border-gray-300 text-gray-600 rounded-2xl hover:bg-gray-50 transition-all duration-300 hover:scale-105 font-semibold"
                >
                  <span class="flex items-center justify-center space-x-2">
                    <Icon name="lucide:share-2" class="w-5 h-5" />
                    <span>Compartir</span>
                  </span>
                </button>
              </div>
            </div>

            <!-- Información adicional -->
            <div class="bg-gradient-to-br from-pink-50 to-orange-50/50 rounded-2xl p-6">
              <h3 class="font-semibold text-gray-800 mb-3 flex items-center">
                <Icon name="lucide:info" class="w-5 h-5 text-pink-500 mr-2" />
                Información del servicio
              </h3>
              <div class="space-y-2 text-sm text-gray-600">
                <div class="flex justify-between">
                  <span>Categoría:</span>
                  <span class="font-medium">{{ servicio.categoria }}</span>
                </div>
                <div class="flex justify-between">
                  <span>Duración:</span>
                  <span class="font-medium">{{ servicio.duracion }} minutos</span>
                </div>
                <div class="flex justify-between">
                  <span>Tipo de cita:</span>
                  <span class="font-medium">{{ servicio.tipoCita || 'Presencial' }}</span>
                </div>
                <div class="flex justify-between">
                  <span>Cancelación:</span>
                  <span class="font-medium text-green-600">Gratis hasta 24h antes</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Detalles del servicio -->
    <section class="py-12 px-6 bg-gradient-to-r from-white via-pink-50/10 to-orange-50/10">
      <div class="max-w-6xl mx-auto">
        <div class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50" data-aos="fade-up">
          <h2 class="text-2xl font-bold text-gray-800 mb-6">Detalles del Servicio</h2>
          
          <div class="grid md:grid-cols-2 gap-8">
            <!-- Incluye -->
            <div>
              <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                <Icon name="lucide:check-circle" class="w-5 h-5 text-green-500 mr-2" />
                Qué incluye
              </h3>
              <ul class="space-y-2 text-gray-600">
                <li v-for="item in servicio.incluye" :key="item" class="flex items-center space-x-2">
                  <Icon name="lucide:check" class="w-4 h-4 text-green-500" />
                  <span>{{ item }}</span>
                </li>
              </ul>
            </div>

            <!-- Proceso -->
            <div>
              <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                <Icon name="lucide:list" class="w-5 h-5 text-blue-500 mr-2" />
                Proceso paso a paso
              </h3>
              <ol class="space-y-2 text-gray-600">
                <li v-for="(paso, index) in servicio.proceso" :key="index" class="flex items-start space-x-2">
                  <span class="flex-shrink-0 w-5 h-5 bg-pink-500 text-white text-xs rounded-full flex items-center justify-center font-semibold">
                    {{ index + 1 }}
                  </span>
                  <span>{{ paso }}</span>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Profesionales -->
    <section class="py-12 px-6">
      <div class="max-w-6xl mx-auto">
        <h2 class="text-2xl font-bold text-center mb-8 text-gray-800" data-aos="fade-up">
          Nuestros Especialistas
        </h2>
        
        <div class="grid md:grid-cols-3 gap-6">
          <div 
            v-for="(especialista, index) in servicio.especialistas"
            :key="index"
            class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1 border border-pink-100/50 text-center"
            data-aos="fade-up"
            :data-aos-delay="index * 100"
          >
            <img 
              :src="especialista.foto" 
              :alt="especialista.nombre"
              class="w-20 h-20 rounded-full mx-auto mb-4 border-4 border-pink-200"
            />
            <h3 class="font-semibold text-gray-800 mb-2">{{ especialista.nombre }}</h3>
            <p class="text-sm text-gray-600 mb-3">{{ especialista.especialidad }}</p>
            <div class="flex justify-center space-x-1 mb-3">
              <Icon v-for="n in 5" :key="n" name="lucide:star" class="w-4 h-4 text-yellow-400 fill-current" />
            </div>
            <p class="text-xs text-gray-500">{{ especialista.experiencia }} años de experiencia</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Servicios relacionados -->
    <section class="py-12 px-6 bg-gradient-to-br from-purple-50/20 to-pink-50/20">
      <div class="max-w-6xl mx-auto">
        <h2 class="text-2xl font-bold text-center mb-8 text-gray-800" data-aos="fade-up">
          Servicios Relacionados
        </h2>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <div 
            v-for="(related, index) in serviciosRelacionados"
            :key="related.id"
            class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1 border border-pink-100/50 cursor-pointer"
            data-aos="fade-up"
            :data-aos-delay="index * 100"
            @click="$router.push(`/servicio/${related.id}`)"
          >
            <div class="relative h-48 overflow-hidden">
              <img 
                :src="related.imagen" 
                :alt="related.nombre"
                class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300"
              />
            </div>
            <div class="p-6">
              <h3 class="font-semibold text-gray-800 mb-2 group-hover:text-pink-600 transition-colors">
                {{ related.nombre }}
              </h3>
              <p class="text-sm text-gray-600 mb-3">{{ related.descripcion }}</p>
              <div class="flex items-center justify-between">
                <span class="text-lg font-bold text-pink-600">${{ related.precio }}</span>
                <span class="text-sm text-gray-500">{{ related.duracion }} min</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
// Obtener ID del servicio de la ruta
const route = useRoute()
const servicioId = parseInt(route.params.id)

// Base de datos de servicios
const servicios = [
  {
    id: 1,
    nombre: 'Tratamiento Facial Hidratante Premium',
    precio: 80,
    categoria: 'Facial',
    icon: '✨',
    descripcion: 'Tratamiento facial profundo con ácido hialurónico para hidratación y rejuvenecimiento',
    descripcionCompleta: 'Nuestro tratamiento facial hidratante premium combina las técnicas más avanzadas con productos de alta gama. Incluye limpieza profunda, exfoliación suave, aplicación de ácido hialurónico, masaje facial relajante y mascarilla nutritiva. Ideal para pieles secas, deshidratadas o que necesitan un boost de luminosidad.',
    imagen: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=500&h=600&fit=crop&crop=center',
    rating: 5,
    reviews: 156,
    duracion: 90,
    disponible: true,
    popular: true,
    nuevo: false,
    proximaCita: 'Mañana 2:00 PM',
    tipoCita: 'Presencial',
    incluye: [
      'Consulta personalizada de piel',
      'Limpieza profunda con vapor',
      'Exfoliación enzimática suave',
      'Extracción de impurezas (si es necesario)',
      'Masaje facial relajante 20 min',
      'Mascarilla de ácido hialurónico',
      'Aplicación de sérum y crema hidratante',
      'Protector solar facial'
    ],
    proceso: [
      'Análisis personalizado del tipo de piel',
      'Desmaquillado y limpieza inicial',
      'Vapor facial para abrir poros',
      'Exfoliación suave con productos naturales',
      'Extracción manual de impurezas',
      'Masaje facial con técnicas de lifting',
      'Aplicación de mascarilla hidratante',
      'Finalización con sérum y protección solar'
    ],
    especialistas: [
      {
        nombre: 'María González',
        especialidad: 'Especialista en Cuidado Facial',
        experiencia: 8,
        foto: 'https://images.unsplash.com/photo-1594824904015-3c05600b4e14?w=150&h=150&fit=crop&crop=face'
      },
      {
        nombre: 'Ana Martínez',
        especialidad: 'Dermocosmética',
        experiencia: 6,
        foto: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150&h=150&fit=crop&crop=face'
      }
    ]
  },
  {
    id: 2,
    nombre: 'Corte y Peinado Moderno',
    precio: 45,
    categoria: 'Cabello',
    icon: '✂️',
    descripcion: 'Corte personalizado y peinado profesional adaptado a tu estilo y tipo de rostro',
    descripcionCompleta: 'Nuestro servicio de corte y peinado moderno incluye una consulta personalizada donde analizamos tu tipo de rostro, textura de cabello y estilo de vida para crear el look perfecto. Utilizamos técnicas de corte avanzadas y productos profesionales para un resultado duradero y fácil de mantener.',
    imagen: 'https://images.unsplash.com/photo-1562322140-8baeececf3df?w=500&h=600&fit=crop&crop=center',
    rating: 4,
    reviews: 203,
    duracion: 60,
    disponible: true,
    popular: false,
    nuevo: false,
    proximaCita: 'Hoy 4:30 PM',
    tipoCita: 'Presencial',
    incluye: [
      'Consulta de estilo personalizada',
      'Lavado con champú profesional',
      'Corte personalizado',
      'Peinado con técnicas modernas',
      'Aplicación de productos de acabado',
      'Consejos de mantenimiento en casa'
    ],
    proceso: [
      'Consulta de estilo y análisis facial',
      'Lavado con champú y acondicionador',
      'Corte personalizado según tu rostro',
      'Secado y peinado profesional',
      'Aplicación de productos de fijación',
      'Retoques finales y consejos de cuidado'
    ],
    especialistas: [
      {
        nombre: 'Carlos Rivera',
        especialidad: 'Estilista Senior',
        experiencia: 12,
        foto: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face'
      },
      {
        nombre: 'Sofia López',
        especialidad: 'Colorista y Estilista',
        experiencia: 9,
        foto: 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=150&h=150&fit=crop&crop=face'
      }
    ]
  }
]

// Encontrar el servicio actual
const servicio = computed(() => {
  return servicios.find(s => s.id === servicioId) || servicios[0]
})

// Servicios relacionados (misma categoría)
const serviciosRelacionados = computed(() => {
  return servicios
    .filter(s => s.id !== servicioId && s.categoria === servicio.value.categoria)
    .slice(0, 3)
})

// SEO dinámico
useHead(() => ({
  title: `${servicio.value.nombre} - Toda Bonita`,
  meta: [
    { name: 'description', content: servicio.value.descripcionCompleta || servicio.value.descripcion },
    { name: 'keywords', content: `${servicio.value.nombre}, ${servicio.value.categoria}, servicio belleza, Toda Bonita` },
    { property: 'og:title', content: `${servicio.value.nombre} - Toda Bonita` },
    { property: 'og:description', content: servicio.value.descripcion },
    { property: 'og:image', content: servicio.value.imagen },
    { property: 'og:type', content: 'service' }
  ]
}))

// Inicializar AOS
onMounted(() => {
  if (typeof window !== 'undefined' && window.AOS) {
    window.AOS.init({
      duration: 600,
      easing: 'ease-out-cubic',
      once: true,
      offset: 100
    })
  }
})

// Funciones
const addToFavorites = () => {
  alert(`${servicio.value.nombre} agregado a favoritos!`)
}

const shareService = () => {
  if (navigator.share) {
    navigator.share({
      title: servicio.value.nombre,
      text: servicio.value.descripcion,
      url: window.location.href
    })
  } else {
    // Fallback para navegadores que no soportan Web Share API
    navigator.clipboard.writeText(window.location.href)
    alert('Enlace copiado al portapapeles!')
  }
}
</script>

<style scoped>
/* Estilos adicionales si son necesarios */
</style>