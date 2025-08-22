<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/20 to-orange-50/10">
    <!-- Header Section -->
    <div class="bg-white shadow-sm">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="text-center">
          <h1 class="text-4xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent mb-4">
            Nuestros Servicios
          </h1>
          <p class="text-gray-600 max-w-2xl mx-auto">
            Descubre nuestra amplia gama de servicios de belleza diseñados para realzar tu belleza natural y hacerte sentir radiante.
          </p>
        </div>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Search and Filters -->
      <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between mb-8 space-y-4 lg:space-y-0">
        <!-- Search Bar -->
        <div class="relative max-w-md w-full">
          <input 
            v-model="searchTerm"
            type="text" 
            placeholder="Buscar servicios..." 
            class="w-full pl-12 pr-4 py-3 border-2 border-pink-100 rounded-2xl focus:outline-none focus:border-pink-300 transition-colors bg-white"
          >
          <Icon name="lucide:search" class="absolute left-4 top-1/2 transform -translate-y-1/2 text-pink-400 text-xl" />
        </div>

        <!-- Sort Options -->
        <div class="flex space-x-3">
          <div class="flex items-center space-x-2">
            <Icon name="lucide:arrow-up-down" class="text-pink-500 text-lg" />
            <select v-model="sortBy" class="px-4 py-2 border border-pink-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300 bg-white">
              <option value="name">Nombre</option>
              <option value="price-low">Precio: Menor a Mayor</option>
              <option value="price-high">Precio: Mayor a Menor</option>
              <option value="duration">Duración</option>
              <option value="popular">Más Popular</option>
              <option value="rating">Mejor Valorados</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Categories -->
      <div class="mb-8">
        <div class="flex flex-wrap gap-3 justify-center lg:justify-start">
          <button 
            v-for="categoria in categorias" 
            :key="categoria"
            @click="filtroCategoria = filtroCategoria === categoria ? '' : categoria"
            :class="filtroCategoria === categoria 
              ? 'bg-gradient-to-r from-pink-500 to-orange-500 text-white shadow-lg' 
              : 'bg-white text-gray-700 hover:bg-pink-50 border border-pink-100'"
            class="px-6 py-3 rounded-2xl font-medium transition-all duration-300 hover:shadow-md"
          >
            {{ categoria }}
          </button>
        </div>
      </div>

      <!-- Services Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div 
          v-for="servicio in serviciosFiltrados" 
          :key="servicio.id"
          class="bg-white rounded-3xl shadow-lg hover:shadow-xl transition-all duration-300 group overflow-hidden"
        >
          <!-- Service Image -->
          <div class="relative overflow-hidden rounded-t-3xl">
            <img 
              :src="servicio.imagen" 
              :alt="servicio.nombre"
              class="w-full h-48 object-cover group-hover:scale-110 transition-transform duration-500"
            >
            <div class="absolute top-4 left-4">
              <span v-if="servicio.promocion" class="bg-red-500 text-white px-3 py-1 rounded-full text-sm font-bold">
                {{ servicio.promocion }}
              </span>
            </div>
            <div class="absolute top-4 right-4">
              <span class="bg-white bg-opacity-90 text-gray-700 px-3 py-1 rounded-full text-sm font-medium">
                {{ servicio.duracion }} min
              </span>
            </div>
          </div>

          <!-- Service Info -->
          <div class="p-6">
            <div class="flex items-center mb-2">
              <span class="text-2xl mr-2">{{ servicio.icono }}</span>
              <span class="text-sm text-pink-500 font-medium">{{ servicio.categoria }}</span>
            </div>
            
            <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-pink-600 transition-colors">
              {{ servicio.nombre }}
            </h3>
            
            <p class="text-gray-600 text-sm mb-4 line-clamp-3">
              {{ servicio.descripcion }}
            </p>

            <!-- Service Details -->
            <div class="space-y-2 mb-4">
              <div class="flex items-center text-sm text-gray-500">
                <Icon name="lucide:clock" class="mr-2 text-pink-500" size="16" />
                <span>Duración: {{ servicio.duracion }} minutos</span>
              </div>
              <div class="flex items-center text-sm text-gray-500">
                <Icon name="lucide:user" class="mr-2 text-pink-500" size="16" />
                <span>Especialista: {{ servicio.especialista }}</span>
              </div>
              <div v-if="servicio.incluye" class="flex items-center text-sm text-gray-500">
                <Icon name="lucide:sparkles" class="mr-2 text-pink-500" size="16" />
                <span>Incluye: {{ servicio.incluye }}</span>
              </div>
            </div>

            <!-- Rating -->
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <Icon 
                  v-for="i in 5" 
                  :key="i" 
                  :name="i <= servicio.rating ? 'lucide:star' : 'lucide:star'"
                  :class="i <= servicio.rating ? 'text-yellow-400' : 'text-gray-300'"
                  size="16"
                  :fill="i <= servicio.rating ? 'currentColor' : 'none'"
                />
              </div>
              <span class="text-gray-500 text-sm ml-2">({{ servicio.reviews }} reseñas)</span>
            </div>

            <!-- Price -->
            <div class="flex items-center justify-between mb-4">
              <div class="flex items-center space-x-2">
                <span v-if="servicio.precioOriginal" class="text-gray-400 line-through text-sm">
                  ${{ servicio.precioOriginal.toLocaleString() }}
                </span>
                <span class="text-2xl font-bold text-pink-600">
                  ${{ servicio.precio.toLocaleString() }}
                </span>
              </div>
            </div>

            <!-- Actions -->
            <div class="flex space-x-2">
              <button 
                @click="bookService(servicio)"
                class="flex-1 bg-gradient-to-r from-pink-500 to-orange-500 text-white py-3 px-4 rounded-xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105 flex items-center justify-center space-x-2"
              >
                <Icon name="lucide:calendar" size="18" />
                <span>Reservar</span>
              </button>
              <button 
                @click="viewService(servicio)"
                class="px-4 py-3 border border-pink-200 rounded-xl text-pink-600 hover:bg-pink-50 transition-colors flex items-center justify-center"
              >
                <Icon name="lucide:eye" size="18" />
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Load More -->
      <div v-if="hasMoreServices" class="text-center mt-12">
        <button 
          @click="loadMore"
          class="bg-gradient-to-r from-pink-500 to-orange-500 text-white py-3 px-8 rounded-2xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105"
        >
          Ver Más Servicios
        </button>
      </div>

      <!-- CTA Section -->
      <div class="mt-16 bg-gradient-to-r from-pink-500 to-orange-500 rounded-3xl p-8 text-white text-center">
        <h2 class="text-3xl font-bold mb-4">¿No encuentras lo que buscas?</h2>
        <p class="text-pink-100 mb-6 max-w-2xl mx-auto">
          Contáctanos para servicios personalizados o consultas sobre tratamientos especiales. 
          Nuestro equipo estará encantado de ayudarte.
        </p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <NuxtLink to="/contacto" 
                    class="bg-white text-pink-600 py-3 px-6 rounded-xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105 flex items-center justify-center space-x-2">
            <Icon name="lucide:message-circle" size="18" />
            <span>Contáctanos</span>
          </NuxtLink>
          <NuxtLink to="/reserva" 
                    class="border-2 border-white text-white py-3 px-6 rounded-xl font-medium hover:bg-white hover:text-pink-600 transition-all duration-300 flex items-center justify-center space-x-2">
            <Icon name="lucide:phone" size="18" />
            <span>Llamar Ahora</span>
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
useHead({
  title: 'Servicios - Toda Bonita',
  meta: [
    { name: 'description', content: 'Descubre nuestra amplia gama de servicios de belleza profesionales en Toda Bonita.' }
  ]
})

const searchTerm = ref('')
const filtroCategoria = ref('')
const sortBy = ref('name')
const currentPage = ref(1)
const itemsPerPage = 9

const categorias = [
  'Todos',
  'Peluquería',
  'Tratamientos Faciales',
  'Manicura',
  'Masajes',
  'Depilaciones',
  'Extensiones de Pestañas',
  'Mascarillas Personalizadas'
]

const servicios = ref([
  {
    id: 1,
    nombre: 'Botox Capilar',
    descripcion: 'Tratamiento reconstructivo que devuelve la vitalidad y brillo natural al cabello. Repara fibras capilares dañadas y sella las cutículas.',
    precio: 95000,
    categoria: 'Peluquería',
    imagen: '/img/servicio_peluqueria.jpg',
    duracion: 120,
    especialista: 'Diana Silva',
    incluye: 'Lavado, aplicación botox, secado',
    rating: 5,
    reviews: 156,
    icono: '💉'
  },
  {
    id: 2,
    nombre: 'Keratina',
    descripcion: 'Tratamiento alisador y nutritivo que reduce el frizz, suaviza el cabello y facilita el peinado diario.',
    precio: 120000,
    categoria: 'Peluquería',
    imagen: '/img/servicio_peluqueria2.jpg',
    duracion: 180,
    especialista: 'Valentina Torres',
    incluye: 'Keratina profesional, secado, planchado',
    rating: 5,
    reviews: 134,
    icono: '🧬'
  },
  {
    id: 3,
    nombre: 'Mechas',
    descripcion: 'Técnicas modernas de coloración: mechas, balayage, babylights. Ilumina tu cabello con reflejos naturales.',
    precio: 85000,
    categoria: 'Peluquería',
    imagen: '/img/servicio_peluqueria3.jpg',
    duracion: 150,
    especialista: 'Carlos Mendoza',
    incluye: 'Decoloración, tinte, tratamiento',
    rating: 5,
    reviews: 189,
    icono: '🎨'
  },
  {
    id: 4,
    nombre: 'Tinte',
    descripcion: 'Coloración completa con productos profesionales. Cambio de color total o cobertura de canas.',
    precio: 65000,
    categoria: 'Peluquería',
    imagen: '/img/servicio_peluqueria4.jpg',
    duracion: 90,
    especialista: 'Isabella Restrepo',
    incluye: 'Tinte profesional, lavado, secado',
    rating: 4,
    reviews: 98,
    icono: '🌈'
  },
  {
    id: 5,
    nombre: 'Alisado',
    descripcion: 'Alisado progresivo con productos naturales que reduce el volumen y facilita el peinado diario.',
    precio: 150000,
    categoria: 'Peluquería',
    imagen: '/img/servicio_unas.jpg',
    duracion: 240,
    especialista: 'Camila Vega',
    incluye: 'Alisado progresivo, tratamiento',
    rating: 4,
    reviews: 87,
    icono: '💇‍♀️'
  },
  {
    id: 6,
    nombre: 'Extracción de Tinte Negro',
    descripcion: 'Proceso especializado para remover tintes oscuros y preparar el cabello para nuevos colores.',
    precio: 180000,
    categoria: 'Peluquería',
    imagen: '/img/servicio_peluqueria.jpg',
    duracion: 300,
    especialista: 'Ana García',
    incluye: 'Decoloración, tratamiento reparador',
    rating: 4,
    reviews: 45,
    icono: '🔬'
  },
  {
    id: 7,
    nombre: 'Extensiones de Pestañas',
    descripcion: 'Extensiones clásicas o volumen para una mirada impactante. Pestañas más largas y densas de forma natural.',
    precio: 80000,
    categoria: 'Extensiones de Pestañas',
    imagen: '/img/servicio_unas.jpg',
    duracion: 120,
    especialista: 'Sofía Martín',
    incluye: 'Aplicación, diseño personalizado',
    rating: 5,
    reviews: 203,
    icono: '👁️'
  },
  {
    id: 8,
    nombre: 'Manicura Clásica',
    descripcion: 'Cuidado completo de uñas con limpieza, corte, limado, cutículas y esmaltado profesional.',
    precio: 45000,
    categoria: 'Manicura',
    imagen: '/img/servicio_unas1.jpg',
    duracion: 60,
    especialista: 'María López',
    incluye: 'Limpieza, esmaltado, hidratación',
    rating: 4,
    reviews: 89,
    icono: '💅'
  },
  {
    id: 9,
    nombre: 'Manicura Semipermanente',
    descripcion: 'Manicura de larga duración con esmalte gel que mantiene el brillo hasta 3 semanas.',
    precio: 65000,
    categoria: 'Manicura',
    imagen: '/img/servicio_unas2.jpg',
    duracion: 75,
    especialista: 'Laura Torres',
    incluye: 'Preparación, gel, curado LED',
    rating: 5,
    reviews: 167,
    icono: '✨'
  },
  {
    id: 10,
    nombre: 'Masaje Relajante',
    descripcion: 'Masaje corporal completo que combina movimientos suaves y profundos para aliviar tensiones.',
    precio: 120000,
    categoria: 'Masajes',
    imagen: '/img/servicio_peluqueria2.jpg',
    duracion: 90,
    especialista: 'Carmen Ruiz',
    incluye: 'Aceites aromáticos, música relajante',
    rating: 5,
    reviews: 156,
    icono: '💆‍♀️'
  },
  {
    id: 11,
    nombre: 'Depilación con Cera',
    descripcion: 'Depilación profesional con cera de alta calidad. Todas las zonas disponibles: piernas, brazos, axilas, cejas.',
    precio: 35000,
    precioOriginal: 45000,
    promocion: '22% OFF',
    categoria: 'Depilaciones',
    imagen: '/img/servicio_peluqueria4.jpg',
    duracion: 45,
    especialista: 'Patricia Vega',
    incluye: 'Cera profesional, cuidado post',
    rating: 4,
    reviews: 67,
    icono: '🪒'
  },
  {
    id: 12,
    nombre: 'Tratamientos Faciales',
    descripcion: 'Limpieza facial profunda, hidratación y tratamientos anti-edad personalizados según tu tipo de piel.',
    precio: 80000,
    categoria: 'Tratamientos Faciales',
    imagen: '/img/servicio_unas3.jpg',
    duracion: 90,
    especialista: 'Dr. Elena Ramírez',
    incluye: 'Limpieza, mascarilla, hidratación',
    rating: 5,
    reviews: 124,
    icono: '🌟'
  },
  {
    id: 13,
    nombre: 'Mascarillas Personalizadas',
    descripcion: 'Mascarillas faciales diseñadas específicamente para tu tipo de piel con ingredientes naturales y activos.',
    precio: 90000,
    categoria: 'Mascarillas Personalizadas',
    imagen: '/img/servicio_peluqueria.jpg',
    duracion: 60,
    especialista: 'Isabella Morales',
    incluye: 'Análisis piel, mascarilla personalizada',
    rating: 5,
    reviews: 78,
    icono: '🧴'
  }
])

const serviciosFiltrados = computed(() => {
  let filtered = servicios.value

  // Filter by search term
  if (searchTerm.value) {
    filtered = filtered.filter(s => 
      s.nombre.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      s.descripcion.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      s.especialista.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      s.categoria.toLowerCase().includes(searchTerm.value.toLowerCase())
    )
  }

  // Filter by category
  if (filtroCategoria.value && filtroCategoria.value !== 'Todos') {
    filtered = filtered.filter(s => s.categoria === filtroCategoria.value)
  }


  // Sort services
  switch (sortBy.value) {
    case 'price-low':
      filtered.sort((a, b) => a.precio - b.precio)
      break
    case 'price-high':
      filtered.sort((a, b) => b.precio - a.precio)
      break
    case 'duration':
      filtered.sort((a, b) => a.duracion - b.duracion)
      break
    case 'popular':
      filtered.sort((a, b) => b.reviews - a.reviews)
      break
    case 'rating':
      filtered.sort((a, b) => b.rating - a.rating)
      break
    default:
      filtered.sort((a, b) => a.nombre.localeCompare(b.nombre))
  }

  return filtered.slice(0, currentPage.value * itemsPerPage)
})

const hasMoreServices = computed(() => {
  return currentPage.value * itemsPerPage < servicios.value.length
})

const bookService = (servicio) => {
  // Navigate to reservation page with pre-selected service
  navigateTo(`/reserva?servicio=${servicio.id}`)
}

const viewService = (servicio) => {
  navigateTo(`/servicio/${servicio.id}`)
}

const loadMore = () => {
  currentPage.value++
}
</script>

<style scoped>
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>