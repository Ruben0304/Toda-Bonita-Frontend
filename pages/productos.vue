<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/20 to-orange-50/10">
    <!-- Header Section -->
    <div class="bg-white shadow-sm">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="text-center">
          <h1 class="text-4xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent mb-4">
            Nuestros Productos
          </h1>
          <p class="text-gray-600 max-w-2xl mx-auto">
            Descubre nuestra selección premium de productos de belleza, cuidadosamente elegidos para realzar tu belleza natural.
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
            placeholder="Buscar productos..." 
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

      <!-- Products Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div 
          v-for="producto in productosFiltrados" 
          :key="producto.id"
          @click="viewProduct(producto)"
          class="bg-white rounded-3xl shadow-lg hover:shadow-xl transition-all duration-300 cursor-pointer group overflow-hidden"
        >
          <!-- Product Image -->
          <div class="relative overflow-hidden rounded-t-3xl">
            <img 
              :src="producto.imagen" 
              :alt="producto.nombre"
              class="w-full h-64 object-cover group-hover:scale-110 transition-transform duration-500"
            >
            <div class="absolute top-4 left-4">
              <span v-if="producto.descuento" class="bg-red-500 text-white px-3 py-1 rounded-full text-sm font-bold">
                -{{ producto.descuento }}%
              </span>
            </div>
            <div class="absolute top-4 right-4">
              <button 
                @click.stop="toggleFavorite(producto)"
                :class="producto.favorito ? 'text-red-500' : 'text-gray-300'"
                class="text-2xl hover:scale-110 transition-transform duration-200"
              >
                ❤️
              </button>
            </div>
          </div>

          <!-- Product Info -->
          <div class="p-6">
            <div class="mb-2">
              <span class="text-sm text-pink-500 font-medium">{{ producto.categoria }}</span>
            </div>
            
            <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-pink-600 transition-colors">
              {{ producto.nombre }}
            </h3>
            
            <p class="text-gray-600 text-sm mb-4 line-clamp-2">
              {{ producto.descripcion }}
            </p>

            <!-- Rating -->
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <span v-for="i in 5" :key="i" class="text-lg">
                  {{ i <= producto.rating ? '⭐' : '☆' }}
                </span>
              </div>
              <span class="text-gray-500 text-sm ml-2">({{ producto.reviews }})</span>
            </div>

            <!-- Price -->
            <div class="flex items-center justify-between">
              <div class="flex items-center space-x-2">
                <span v-if="producto.precioOriginal" class="text-gray-400 line-through text-sm">
                  ${{ producto.precioOriginal.toLocaleString() }}
                </span>
                <span class="text-2xl font-bold text-pink-600">
                  ${{ producto.precio.toLocaleString() }}
                </span>
              </div>
            </div>

            <!-- Actions -->
            <div class="flex space-x-2 mt-4">
              <button 
                @click.stop="addToCart(producto)"
                class="flex-1 bg-gradient-to-r from-pink-500 to-orange-500 text-white py-3 px-4 rounded-xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105"
              >
                🛒 Agregar
              </button>
              <button 
                @click.stop="quickView(producto)"
                class="px-4 py-3 border border-pink-200 rounded-xl text-pink-600 hover:bg-pink-50 transition-colors"
              >
                👁️
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Load More -->
      <div v-if="hasMoreProducts" class="text-center mt-12">
        <button 
          @click="loadMore"
          class="bg-gradient-to-r from-pink-500 to-orange-500 text-white py-3 px-8 rounded-2xl font-medium hover:shadow-lg transition-all duration-300 hover:scale-105"
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
    imagen: 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=400&h=400&fit=crop',
    rating: 5,
    reviews: 128,
    descuento: 20,
    favorito: false
  },
  {
    id: 2,
    nombre: 'Paleta de Sombras Sunset',
    descripcion: 'Paleta con 18 tonos cálidos y vibrantes para looks de día y noche.',
    precio: 89000,
    categoria: 'Maquillaje',
    imagen: 'https://images.unsplash.com/photo-1583241800698-4828ce446e97?w=400&h=400&fit=crop',
    rating: 4,
    reviews: 89,
    favorito: false
  },
  {
    id: 3,
    nombre: 'Crema Hidratante Nocturna',
    descripcion: 'Crema nutritiva que repara y regenera tu piel mientras duermes.',
    precio: 95000,
    categoria: 'Cuidado Facial',
    imagen: 'https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?w=400&h=400&fit=crop',
    rating: 5,
    reviews: 156,
    favorito: true
  },
  {
    id: 4,
    nombre: 'Esmalte Gel Larga Duración',
    descripcion: 'Esmalte gel profesional que dura hasta 3 semanas sin descascararse.',
    precio: 35000,
    categoria: 'Uñas',
    imagen: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=400&h=400&fit=crop',
    rating: 4,
    reviews: 73,
    favorito: false
  },
  {
    id: 5,
    nombre: 'Base de Maquillaje HD',
    descripcion: 'Base líquida de cobertura completa con acabado natural y duradero.',
    precio: 78000,
    categoria: 'Maquillaje',
    imagen: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400&h=400&fit=crop',
    rating: 5,
    reviews: 203,
    favorito: false
  },
  {
    id: 6,
    nombre: 'Aceite Corporal Nutritivo',
    descripcion: 'Aceite multifuncional con extractos naturales para hidratar y suavizar.',
    precio: 67000,
    categoria: 'Cuidado Corporal',
    imagen: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop',
    rating: 4,
    reviews: 91,
    favorito: false
  },
  {
    id: 7,
    nombre: 'Shampoo Reparador Intensivo',
    descripcion: 'Shampoo con queratina y aceites naturales para cabello dañado.',
    precio: 52000,
    categoria: 'Cabello',
    imagen: 'https://images.unsplash.com/photo-1556228578-7ba8b08b1c70?w=400&h=400&fit=crop',
    rating: 4,
    reviews: 112,
    favorito: false
  },
  {
    id: 8,
    nombre: 'Perfume Floral Elegance',
    descripcion: 'Fragancia femenina con notas florales y un toque de vainilla.',
    precio: 145000,
    categoria: 'Fragancias',
    imagen: 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400&h=400&fit=crop',
    rating: 5,
    reviews: 67,
    favorito: true
  }
])

const productosFiltrados = computed(() => {
  let filtered = productos.value

  // Filter by search term
  if (searchTerm.value) {
    filtered = filtered.filter(p => 
      p.nombre.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      p.descripcion.toLowerCase().includes(searchTerm.value.toLowerCase())
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
</style>