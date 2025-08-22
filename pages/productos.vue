<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/20 to-orange-50/10">
    <!-- Header Section -->
    <div class="bg-white shadow-sm">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-12">
        <div class="text-center">
          <h1 
            class="text-3xl sm:text-4xl lg:text-5xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent mb-4"
            data-aos="fade-up"
            data-aos-duration="800"
          >
            Nuestros Productos
          </h1>
          <p 
            class="text-gray-600 max-w-2xl mx-auto text-sm sm:text-base lg:text-lg"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="800"
          >
            Descubre nuestra selección premium de productos de belleza, cuidadosamente elegidos para realzar tu belleza natural.
          </p>
        </div>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-12">
      <!-- Search and Filters -->
      <div 
        class="flex flex-col lg:flex-row lg:items-center lg:justify-between mb-8 lg:mb-12 space-y-4 lg:space-y-0"
        data-aos="fade-up"
        data-aos-delay="400"
        data-aos-duration="600"
      >
        <!-- Search Bar -->
        <div class="relative max-w-md w-full lg:max-w-lg">
          <input 
            v-model="searchTerm"
            type="text" 
            placeholder="Buscar productos..." 
            class="w-full pl-12 pr-4 py-3 text-sm sm:text-base border-2 border-pink-100 rounded-2xl focus:outline-none focus:border-pink-300 transition-colors bg-white shadow-sm hover:shadow-md"
          >
          <Icon name="lucide:search" class="absolute left-4 top-1/2 transform -translate-y-1/2 text-pink-400 text-lg sm:text-xl" />
        </div>

        <!-- Sort Options -->
        <div class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-3">
          <div class="flex items-center space-x-2">
            <Icon name="lucide:arrow-up-down" class="text-pink-500 text-sm sm:text-lg" />
            <select 
              v-model="sortBy" 
              class="px-3 sm:px-4 py-2 text-sm sm:text-base border border-pink-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300 bg-white shadow-sm hover:shadow-md transition-all"
            >
              <option value="name">Nombre</option>
              <option value="price-low">Precio: Menor a Mayor</option>
              <option value="price-high">Precio: Mayor a Menor</option>
              <option value="popular">Más Popular</option>
              <option value="rating">Mejor Valorados</option>
              <option value="newest">Más Nuevos</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Categories -->
      <div 
        class="mb-8 lg:mb-12"
        data-aos="fade-up"
        data-aos-delay="600"
        data-aos-duration="600"
      >
        <div class="flex flex-wrap gap-2 sm:gap-3 justify-center lg:justify-start">
          <button 
            v-for="(categoria, index) in categorias" 
            :key="categoria"
            @click="filtroCategoria = filtroCategoria === categoria ? '' : categoria"
            :class="filtroCategoria === categoria 
              ? 'bg-gradient-to-r from-pink-500 to-orange-500 text-white shadow-lg scale-105' 
              : 'bg-white text-gray-700 hover:bg-pink-50 border border-pink-100 hover:border-pink-200'"
            class="px-4 sm:px-6 py-2 sm:py-3 rounded-2xl font-medium transition-all duration-300 hover:shadow-md hover:scale-102 text-sm sm:text-base"
            :data-aos="'zoom-in'"
            :data-aos-delay="600 + (index * 100)"
            data-aos-duration="400"
          >
            {{ categoria }}
          </button>
        </div>
      </div>

      <!-- Products Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 sm:gap-6">
        <div 
          v-for="(producto, index) in productosFiltrados" 
          :key="producto.id"
          @click="viewProduct(producto)"
          class="bg-white rounded-2xl sm:rounded-3xl shadow-lg hover:shadow-xl transition-all duration-300 cursor-pointer group overflow-hidden hover:scale-105"
          data-aos="fade-up"
          :data-aos-delay="800 + (index * 100)"
          data-aos-duration="600"
        >
          <!-- Product Image -->
          <div class="relative overflow-hidden rounded-t-2xl sm:rounded-t-3xl">
            <img 
              :src="producto.imagen" 
              :alt="producto.nombre"
              class="w-full h-48 sm:h-56 lg:h-64 object-cover group-hover:scale-110 transition-transform duration-500"
            >
            <div class="absolute top-3 sm:top-4 left-3 sm:left-4">
              <span v-if="producto.descuento" class="bg-red-500 text-white px-2 sm:px-3 py-1 rounded-full text-xs sm:text-sm font-bold shadow-lg">
                -{{ producto.descuento }}%
              </span>
            </div>
            <div class="absolute top-3 sm:top-4 right-3 sm:right-4">
              <button 
                @click.stop="toggleFavorite(producto)"
                :class="producto.favorito ? 'text-red-500 scale-110' : 'text-gray-300 hover:text-red-400'"
                class="text-xl sm:text-2xl hover:scale-110 transition-all duration-200 bg-white/80 backdrop-blur-sm rounded-full p-1 sm:p-2 shadow-md"
              >
                <Icon 
                  name="lucide:heart" 
                  :fill="producto.favorito ? 'currentColor' : 'none'"
                  size="20"
                />
              </button>
            </div>
            <!-- Overlay gradient for better text readability -->
            <div class="absolute inset-0 bg-gradient-to-t from-black/20 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
          </div>

          <!-- Product Info -->
          <div class="p-4 sm:p-6">
            <div class="mb-2">
              <span class="text-xs sm:text-sm text-pink-500 font-medium bg-pink-50 px-2 py-1 rounded-full">{{ producto.categoria }}</span>
            </div>
            
            <h3 class="text-lg sm:text-xl font-bold text-gray-900 mb-2 group-hover:text-pink-600 transition-colors line-clamp-2">
              {{ producto.nombre }}
            </h3>
            
            <p class="text-gray-600 text-xs sm:text-sm mb-3 sm:mb-4 line-clamp-2">
              {{ producto.descripcion }}
            </p>

            <!-- Rating -->
            <div class="flex items-center mb-3 sm:mb-4">
              <div class="flex text-yellow-400">
                <Icon 
                  v-for="i in 5" 
                  :key="i" 
                  name="lucide:star"
                  :class="i <= producto.rating ? 'text-yellow-400' : 'text-gray-300'"
                  size="16"
                  :fill="i <= producto.rating ? 'currentColor' : 'none'"
                />
              </div>
              <span class="text-gray-500 text-xs sm:text-sm ml-2">({{ producto.reviews }})</span>
            </div>

            <!-- Price -->
            <div class="flex items-center justify-between mb-3 sm:mb-4">
              <div class="flex items-center space-x-1 sm:space-x-2">
                <span v-if="producto.precioOriginal" class="text-gray-400 line-through text-xs sm:text-sm">
                  ${{ producto.precioOriginal.toLocaleString() }}
                </span>
                <span class="text-xl sm:text-2xl font-bold text-pink-600">
                  ${{ producto.precio.toLocaleString() }}
                </span>
              </div>
            </div>

            <!-- Actions -->
            <div class="flex space-x-2">
              <button 
                @click.stop="addToCart(producto)"
                class="flex-1 bg-gradient-to-r from-pink-500 to-orange-500 text-white py-2 sm:py-3 px-3 sm:px-4 rounded-xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105 text-xs sm:text-sm flex items-center justify-center space-x-1 sm:space-x-2"
              >
                <Icon name="lucide:shopping-cart" size="16" />
                <span class="hidden sm:inline">Agregar</span>
              </button>
              <button 
                @click.stop="quickView(producto)"
                class="px-3 sm:px-4 py-2 sm:py-3 border border-pink-200 rounded-xl text-pink-600 hover:bg-pink-50 transition-colors text-xs sm:text-sm flex items-center justify-center"
              >
                <Icon name="lucide:eye" size="16" />
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Load More -->
      <div 
        v-if="hasMoreProducts" 
        class="text-center mt-8 sm:mt-12"
        data-aos="fade-up"
        data-aos-delay="1000"
        data-aos-duration="600"
      >
        <button 
          @click="loadMore"
          class="bg-gradient-to-r from-pink-500 to-orange-500 text-white py-3 px-6 sm:px-8 rounded-2xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105 text-sm sm:text-base"
        >
          Ver Más Productos
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
useHead({
  title: 'Productos - Toda Bonita',
  meta: [
    { name: 'description', content: 'Descubre nuestra colección de productos de belleza premium para realzar tu belleza natural.' }
  ]
})

const searchTerm = ref('')
const filtroCategoria = ref('')
const sortBy = ref('name')
const currentPage = ref(1)
const itemsPerPage = 12

const categorias = [
  'Todas',
  'Cuidado Facial',
  'Maquillaje',
  'Cuidado Corporal',
  'Uñas',
  'Cabello',
  'Fragancias'
]

const productos = ref([
  {
    id: 1,
    nombre: 'Serum Vitamina C Premium',
    descripcion: 'Serum antioxidante con vitamina C pura para iluminar y proteger tu piel.',
    precio: 120000,
    precioOriginal: 150000,
    categoria: 'Cuidado Facial',
    imagen: '/img/producto1.jpg',
    rating: 5,
    reviews: 128,
    descuento: 20,
    favorito: false,
    stock: 15
  },
  {
    id: 2,
    nombre: 'Paleta de Sombras Sunset',
    descripcion: 'Paleta con 18 tonos cálidos y vibrantes para looks de día y noche.',
    precio: 89000,
    categoria: 'Maquillaje',
    imagen: '/img/producto2.jpg',
    rating: 4,
    reviews: 89,
    favorito: false,
    stock: 8
  },
  {
    id: 3,
    nombre: 'Crema Hidratante Nocturna',
    descripcion: 'Crema nutritiva que repara y regenera tu piel mientras duermes.',
    precio: 95000,
    categoria: 'Cuidado Facial',
    imagen: '/img/producto3.jpg',
    rating: 5,
    reviews: 156,
    favorito: true,
    stock: 12
  },
  {
    id: 4,
    nombre: 'Esmalte Gel Larga Duración',
    descripcion: 'Esmalte gel profesional que dura hasta 3 semanas sin descascararse.',
    precio: 35000,
    categoria: 'Uñas',
    imagen: '/img/producto1.jpg',
    rating: 4,
    reviews: 73,
    favorito: false,
    stock: 25
  },
  {
    id: 5,
    nombre: 'Base de Maquillaje HD',
    descripcion: 'Base líquida de cobertura completa con acabado natural y duradero.',
    precio: 78000,
    categoria: 'Maquillaje',
    imagen: '/img/producto2.jpg',
    rating: 5,
    reviews: 203,
    favorito: false,
    stock: 6
  },
  {
    id: 6,
    nombre: 'Aceite Corporal Nutritivo',
    descripcion: 'Aceite multifuncional con extractos naturales para hidratar y suavizar.',
    precio: 67000,
    categoria: 'Cuidado Corporal',
    imagen: '/img/producto3.jpg',
    rating: 4,
    reviews: 91,
    favorito: false,
    stock: 18
  },
  {
    id: 7,
    nombre: 'Shampoo Reparador Intensivo',
    descripcion: 'Shampoo con queratina y aceites naturales para cabello dañado.',
    precio: 52000,
    categoria: 'Cabello',
    imagen: '/img/producto1.jpg',
    rating: 4,
    reviews: 112,
    favorito: false,
    stock: 22
  },
  {
    id: 8,
    nombre: 'Perfume Floral Elegance',
    descripcion: 'Fragancia femenina con notas florales y un toque de vainilla.',
    precio: 145000,
    categoria: 'Fragancias',
    imagen: '/img/producto2.jpg',
    rating: 5,
    reviews: 67,
    favorito: true,
    stock: 4
  }
])

const productosFiltrados = computed(() => {
  let filtered = productos.value

  // Filter by search term
  if (searchTerm.value) {
    filtered = filtered.filter(p => 
      p.nombre.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      p.descripcion.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      p.categoria.toLowerCase().includes(searchTerm.value.toLowerCase())
    )
  }

  // Filter by category
  if (filtroCategoria.value && filtroCategoria.value !== 'Todas') {
    filtered = filtered.filter(p => p.categoria === filtroCategoria.value)
  }


  // Sort products
  switch (sortBy.value) {
    case 'price-low':
      filtered.sort((a, b) => a.precio - b.precio)
      break
    case 'price-high':
      filtered.sort((a, b) => b.precio - a.precio)
      break
    case 'popular':
      filtered.sort((a, b) => b.reviews - a.reviews)
      break
    case 'rating':
      filtered.sort((a, b) => b.rating - a.rating)
      break
    case 'newest':
      filtered.sort((a, b) => b.id - a.id)
      break
    default:
      filtered.sort((a, b) => a.nombre.localeCompare(b.nombre))
  }

  return filtered.slice(0, currentPage.value * itemsPerPage)
})

const hasMoreProducts = computed(() => {
  return currentPage.value * itemsPerPage < productos.value.length
})

const viewProduct = (producto) => {
  navigateTo(`/producto/${producto.id}`)
}

const addToCart = (producto) => {
  // Add to cart logic here
  alert(`${producto.nombre} agregado al carrito`)
}

const toggleFavorite = (producto) => {
  producto.favorito = !producto.favorito
}

const quickView = (producto) => {
  // Quick view modal logic here
  alert(`Vista rápida de ${producto.nombre}`)
}

const loadMore = () => {
  currentPage.value++
}
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* Additional responsive utilities */
.hover\:scale-102:hover {
  transform: scale(1.02);
}

/* Smooth transitions for all interactive elements */
button, input, select {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Better mobile grid spacing */
@media (max-width: 640px) {
  .grid {
    gap: 1rem;
  }
}

/* Enhanced hover effects */
.group:hover .group-hover\:scale-110 {
  transform: scale(1.1);
}

/* Backdrop blur support fallback */
@supports not (backdrop-filter: blur(4px)) {
  .backdrop-blur-sm {
    background-color: rgba(255, 255, 255, 0.9);
  }
}
</style>