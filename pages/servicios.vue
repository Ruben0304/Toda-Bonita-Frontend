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
          <span class="absolute left-4 top-1/2 transform -translate-y-1/2 text-pink-400 text-xl">🔍</span>
        </div>

        <!-- Sort Options -->
        <div class="flex space-x-3">
          <select v-model="sortBy" class="px-4 py-2 border border-pink-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300">
            <option value="name">Nombre</option>
            <option value="price-low">Precio: Menor a Mayor</option>
            <option value="price-high">Precio: Mayor a Menor</option>
            <option value="duration">Duración</option>
            <option value="popular">Más Popular</option>
          </select>
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
                <span class="mr-2">⏱️</span>
                <span>Duración: {{ servicio.duracion }} minutos</span>
              </div>
              <div class="flex items-center text-sm text-gray-500">
                <span class="mr-2">👥</span>
                <span>Especialista: {{ servicio.especialista }}</span>
              </div>
              <div v-if="servicio.incluye" class="flex items-center text-sm text-gray-500">
                <span class="mr-2">✨</span>
                <span>Incluye: {{ servicio.incluye }}</span>
              </div>
            </div>

            <!-- Rating -->
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <span v-for="i in 5" :key="i" class="text-lg">
                  {{ i <= servicio.rating ? '⭐' : '☆' }}
                </span>
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
                class="flex-1 bg-gradient-to-r from-pink-500 to-orange-500 text-white py-3 px-4 rounded-xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105"
              >
                📅 Reservar
              </button>
              <button 
                @click="viewService(servicio)"
                class="px-4 py-3 border border-pink-200 rounded-xl text-pink-600 hover:bg-pink-50 transition-colors"
              >
                👁️
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
                    class="bg-white text-pink-600 py-3 px-6 rounded-xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105">
            💬 Contáctanos
          </NuxtLink>
          <NuxtLink to="/reserva" 
                    class="border-2 border-white text-white py-3 px-6 rounded-xl font-medium hover:bg-white hover:text-pink-600 transition-all duration-300">
            📞 Llamar Ahora
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
  'Cuidado Facial',
  'Manicure & Pedicure',
  'Masajes',
  'Maquillaje',
  'Depilación',
  'Tratamientos Corporales'
]

const servicios = ref([
  {
    id: 1,
    nombre: 'Facial Hidratante Profundo',
    descripcion: 'Tratamiento facial completo con limpieza, exfoliación, mascarilla hidratante y masaje facial relajante. Perfecto para pieles secas y deshidratadas.',
    precio: 80000,
    categoria: 'Cuidado Facial',
    imagen: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=400&h=300&fit=crop',
    duracion: 90,
    especialista: 'Ana García',
    incluye: 'Limpieza, mascarilla, hidratación',
    rating: 5,
    reviews: 124,
    icono: '✨'
  },
  {
    id: 2,
    nombre: 'Manicure Clásico',
    descripcion: 'Cuidado completo de uñas con limpieza, corte, limado, cutículas y esmaltado. Incluye hidratación de manos.',
    precio: 45000,
    categoria: 'Manicure & Pedicure',
    imagen: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=400&h=300&fit=crop',
    duracion: 60,
    especialista: 'María López',
    incluye: 'Limpieza, esmaltado, hidratación',
    rating: 4,
    reviews: 89,
    icono: '💅'
  },
  {
    id: 3,
    nombre: 'Masaje Relajante Sueco',
    descripcion: 'Masaje corporal completo que combina movimientos suaves y profundos para aliviar tensiones y promover la relajación total.',
    precio: 120000,
    categoria: 'Masajes',
    imagen: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400&h=300&fit=crop',
    duracion: 120,
    especialista: 'Carmen Ruiz',
    incluye: 'Aceites aromáticos, música relajante',
    rating: 5,
    reviews: 156,
    icono: '💆‍♀️'
  },
  {
    id: 4,
    nombre: 'Maquillaje para Eventos',
    descripcion: 'Maquillaje profesional para ocasiones especiales. Incluye consulta de estilo y prueba previa.',
    precio: 100000,
    categoria: 'Maquillaje',
    imagen: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=400&h=300&fit=crop',
    duracion: 90,
    especialista: 'Sofía Martín',
    incluye: 'Consulta, prueba, maquillaje',
    rating: 5,
    reviews: 203,
    icono: '💄'
  },
  {
    id: 5,
    nombre: 'Pedicure Spa Completo',
    descripcion: 'Tratamiento relajante para pies que incluye baño de sales, exfoliación, masaje y esmaltado profesional.',
    precio: 55000,
    categoria: 'Manicure & Pedicure',
    imagen: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=300&fit=crop',
    duracion: 75,
    especialista: 'Laura Torres',
    incluye: 'Baño de sales, exfoliación, masaje',
    rating: 4,
    reviews: 91,
    icono: '🦶'
  },
  {
    id: 6,
    nombre: 'Depilación con Cera',
    descripcion: 'Depilación profesional con cera de alta calidad. Zonas disponibles: piernas, brazos, axilas, cejas.',
    precio: 35000,
    precioOriginal: 45000,
    promocion: '22% OFF',
    categoria: 'Depilación',
    imagen: 'https://images.unsplash.com/photo-1515377905703-c4788e51af15?w=400&h=300&fit=crop',
    duracion: 45,
    especialista: 'Patricia Vega',
    incluye: 'Cera profesional, cuidado post',
    rating: 4,
    reviews: 67,
    icono: '🪒'
  },
  {
    id: 7,
    nombre: 'Facial Anti-edad',
    descripcion: 'Tratamiento facial especializado para reducir líneas de expresión y mejorar la elasticidad de la piel.',
    precio: 150000,
    categoria: 'Cuidado Facial',
    imagen: 'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?w=400&h=300&fit=crop',
    duracion: 120,
    especialista: 'Dr. Elena Ramírez',
    incluye: 'Suero anti-edad, masaje facial',
    rating: 5,
    reviews: 78,
    icono: '🌟'
  },
  {
    id: 8,
    nombre: 'Masaje de Piedras Calientes',
    descripcion: 'Masaje terapéutico con piedras volcánicas calientes que ayuda a relajar músculos profundos y aliviar el estrés.',
    precio: 180000,
    categoria: 'Masajes',
    imagen: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=400&h=300&fit=crop',
    duracion: 90,
    especialista: 'Ricardo Silva',
    incluye: 'Piedras volcánicas, aceites',
    rating: 5,
    reviews: 112,
    icono: '🔥'
  },
  {
    id: 9,
    nombre: 'Tratamiento Corporal Reafirmante',
    descripcion: 'Tratamiento corporal completo para reafirmar y tonificar la piel. Incluye exfoliación y envoltura corporal.',
    precio: 200000,
    categoria: 'Tratamientos Corporales',
    imagen: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=300&fit=crop',
    duracion: 150,
    especialista: 'Isabella Morales',
    incluye: 'Exfoliación, envoltura, masaje',
    rating: 4,
    reviews: 45,
    icono: '🏃‍♀️'
  }
])

const serviciosFiltrados = computed(() => {
  let filtered = servicios.value

  // Filter by search term
  if (searchTerm.value) {
    filtered = filtered.filter(s => 
      s.nombre.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      s.descripcion.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      s.especialista.toLowerCase().includes(searchTerm.value.toLowerCase())
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