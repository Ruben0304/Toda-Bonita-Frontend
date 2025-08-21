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

    <!-- Producto Principal -->
    <section class="py-8 px-6">
      <div class="max-w-6xl mx-auto">
        <div class="grid lg:grid-cols-2 gap-12 items-start">
          <!-- Imagen del producto -->
          <div class="space-y-4" data-aos="fade-right">
            <div class="relative group">
              <div class="absolute inset-0 bg-gradient-to-r from-pink-500/20 to-orange-500/20 rounded-3xl blur-xl group-hover:blur-2xl transition-all duration-300 opacity-0 group-hover:opacity-100"></div>
              <div class="relative bg-white rounded-3xl overflow-hidden shadow-lg border border-pink-100/50">
                <img 
                  :src="producto.imagen" 
                  :alt="producto.nombre"
                  class="w-full h-96 lg:h-[500px] object-cover"
                />
                <!-- Badge de descuento -->
                <div v-if="producto.descuento" class="absolute top-6 right-6">
                  <span class="text-sm font-bold text-white bg-red-500 px-3 py-2 rounded-full shadow-lg">
                    -{{ producto.descuento }}%
                  </span>
                </div>
                <!-- Badge de categoría -->
                <div class="absolute top-6 left-6">
                  <span class="text-sm font-semibold uppercase tracking-wider text-white bg-gradient-to-r from-pink-500/90 to-orange-500/90 backdrop-blur-sm px-3 py-2 rounded-full">
                    {{ producto.categoria }}
                  </span>
                </div>
              </div>
            </div>
            <!-- Imágenes adicionales (simuladas) -->
            <div class="grid grid-cols-4 gap-3">
              <div v-for="i in 4" :key="i" class="relative">
                <img 
                  :src="producto.imagen" 
                  :alt="`${producto.nombre} vista ${i}`"
                  class="w-full h-20 object-cover rounded-xl border border-pink-200/50 hover:border-pink-400 transition-colors cursor-pointer"
                />
              </div>
            </div>
          </div>

          <!-- Información del producto -->
          <div class="space-y-6" data-aos="fade-left">
            <!-- Rating y reviews -->
            <div class="flex items-center space-x-4">
              <div class="flex text-yellow-400">
                <span v-for="i in 5" :key="i" class="text-lg">
                  {{ i <= producto.rating ? '⭐' : '☆' }}
                </span>
              </div>
              <span class="text-gray-600">({{ producto.reviews }} reseñas)</span>
              <!-- Tags -->
              <div class="flex space-x-2">
                <span v-if="producto.nuevo" class="text-xs bg-blue-100 text-blue-600 px-2 py-1 rounded-full font-semibold">
                  Nuevo
                </span>
                <span v-if="producto.bestseller" class="text-xs bg-purple-100 text-purple-600 px-2 py-1 rounded-full font-semibold">
                  Bestseller
                </span>
              </div>
            </div>

            <!-- Nombre y descripción -->
            <div>
              <h1 class="text-3xl lg:text-4xl font-bold text-gray-800 mb-4">
                {{ producto.nombre }}
              </h1>
              <p class="text-lg text-gray-600 leading-relaxed">
                {{ producto.descripcionCompleta || producto.descripcion }}
              </p>
            </div>

            <!-- Precio -->
            <div class="flex items-center space-x-4">
              <span 
                v-if="producto.precioOriginal"
                class="text-xl text-gray-400 line-through"
              >
                ${{ producto.precioOriginal }}
              </span>
              <span class="text-4xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
                ${{ producto.precio }}
              </span>
              <div class="text-3xl">{{ producto.icon }}</div>
            </div>

            <!-- Stock -->
            <div class="flex items-center space-x-3">
              <span 
                :class="[
                  'px-3 py-1 rounded-full font-semibold text-sm',
                  producto.stock > 10 
                    ? 'bg-green-100 text-green-600' 
                    : producto.stock > 0 
                      ? 'bg-yellow-100 text-yellow-600' 
                      : 'bg-red-100 text-red-600'
                ]"
              >
                {{ getStockText(producto.stock) }}
              </span>
            </div>

            <!-- Cantidad y agregar al carrito -->
            <div class="space-y-4">
              <div class="flex items-center space-x-4">
                <span class="text-sm font-medium text-gray-700">Cantidad:</span>
                <div class="flex items-center border border-pink-200 rounded-xl">
                  <button 
                    @click="decreaseQuantity"
                    :disabled="quantity <= 1"
                    class="p-2 text-pink-600 hover:bg-pink-50 disabled:text-gray-400 disabled:cursor-not-allowed transition-colors rounded-l-xl"
                  >
                    <Icon name="lucide:minus" class="w-4 h-4" />
                  </button>
                  <span class="px-4 py-2 font-semibold">{{ quantity }}</span>
                  <button 
                    @click="increaseQuantity"
                    :disabled="quantity >= producto.stock"
                    class="p-2 text-pink-600 hover:bg-pink-50 disabled:text-gray-400 disabled:cursor-not-allowed transition-colors rounded-r-xl"
                  >
                    <Icon name="lucide:plus" class="w-4 h-4" />
                  </button>
                </div>
              </div>

              <div class="flex space-x-3">
                <button 
                  @click="addToCart"
                  :disabled="producto.stock === 0"
                  :class="[
                    'flex-1 py-4 rounded-2xl font-bold transition-all duration-300 transform hover:scale-105',
                    producto.stock > 0
                      ? 'bg-gradient-to-r from-pink-500 to-orange-500 text-white hover:shadow-lg'
                      : 'bg-gray-200 text-gray-400 cursor-not-allowed'
                  ]"
                >
                  <span v-if="producto.stock > 0" class="flex items-center justify-center space-x-2">
                    <Icon name="lucide:shopping-cart" class="w-5 h-5" />
                    <span>Agregar al Carrito</span>
                  </span>
                  <span v-else>Agotado</span>
                </button>
                <button 
                  @click="addToWishlist"
                  class="p-4 border-2 border-pink-300 text-pink-600 rounded-2xl hover:bg-pink-50 transition-all duration-300 hover:scale-105"
                  title="Agregar a favoritos"
                >
                  <Icon name="lucide:heart" class="w-5 h-5" />
                </button>
              </div>
            </div>

            <!-- Información adicional -->
            <div class="bg-gradient-to-br from-pink-50 to-orange-50/50 rounded-2xl p-6">
              <h3 class="font-semibold text-gray-800 mb-3 flex items-center">
                <Icon name="lucide:info" class="w-5 h-5 text-pink-500 mr-2" />
                Información del producto
              </h3>
              <div class="space-y-2 text-sm text-gray-600">
                <div class="flex justify-between">
                  <span>Marca:</span>
                  <span class="font-medium">{{ producto.marca || 'Toda Bonita' }}</span>
                </div>
                <div class="flex justify-between">
                  <span>Categoría:</span>
                  <span class="font-medium">{{ producto.categoria }}</span>
                </div>
                <div class="flex justify-between">
                  <span>Tipo de piel:</span>
                  <span class="font-medium">{{ producto.tipoPiel || 'Todo tipo' }}</span>
                </div>
                <div class="flex justify-between">
                  <span>Envío:</span>
                  <span class="font-medium text-green-600">Gratis en compras +$50</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Detalles del producto -->
    <section class="py-12 px-6 bg-gradient-to-r from-white via-pink-50/10 to-orange-50/10">
      <div class="max-w-6xl mx-auto">
        <div class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50" data-aos="fade-up">
          <h2 class="text-2xl font-bold text-gray-800 mb-6">Detalles del Producto</h2>
          
          <div class="grid md:grid-cols-2 gap-8">
            <!-- Ingredientes -->
            <div>
              <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                <Icon name="lucide:leaf" class="w-5 h-5 text-green-500 mr-2" />
                Ingredientes principales
              </h3>
              <ul class="space-y-2 text-gray-600">
                <li v-for="ingrediente in producto.ingredientes" :key="ingrediente" class="flex items-center space-x-2">
                  <Icon name="lucide:check" class="w-4 h-4 text-green-500" />
                  <span>{{ ingrediente }}</span>
                </li>
              </ul>
            </div>

            <!-- Modo de uso -->
            <div>
              <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                <Icon name="lucide:book-open" class="w-5 h-5 text-blue-500 mr-2" />
                Modo de uso
              </h3>
              <ol class="space-y-2 text-gray-600">
                <li v-for="(paso, index) in producto.modoUso" :key="index" class="flex items-start space-x-2">
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

    <!-- Productos relacionados -->
    <section class="py-12 px-6">
      <div class="max-w-6xl mx-auto">
        <h2 class="text-2xl font-bold text-center mb-8 text-gray-800" data-aos="fade-up">
          Productos Relacionados
        </h2>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div 
            v-for="(related, index) in productosRelacionados"
            :key="related.id"
            class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1 border border-pink-100/50 cursor-pointer"
            data-aos="fade-up"
            :data-aos-delay="index * 100"
            @click="$router.push(`/producto/${related.id}`)"
          >
            <div class="relative h-48 overflow-hidden">
              <img 
                :src="related.imagen" 
                :alt="related.nombre"
                class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300"
              />
            </div>
            <div class="p-4">
              <h3 class="font-semibold text-gray-800 mb-2 group-hover:text-pink-600 transition-colors">
                {{ related.nombre }}
              </h3>
              <div class="flex items-center justify-between">
                <span class="text-lg font-bold text-pink-600">${{ related.precio }}</span>
                <div class="flex text-yellow-400 text-sm">
                  <span v-for="i in 5" :key="i">
                    {{ i <= related.rating ? '⭐' : '☆' }}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
// Obtener ID del producto de la ruta
const route = useRoute()
const productId = parseInt(route.params.id)

// Base de datos de productos (misma que en productos.vue)
const productos = [
  {
    id: 1,
    nombre: 'Serum Capilar Reparador Premium',
    precio: 45,
    precioOriginal: 55,
    categoria: 'Cabello',
    icon: '💧',
    descripcion: 'Serum intensivo que repara y fortalece el cabello dañado con tecnología de queratina avanzada',
    descripcionCompleta: 'Serum capilar de alta gama formulado con queratina hidrolizada, aceite de argán y complejo vitamínico B. Repara instantáneamente el cabello dañado, sella las cutículas y proporciona brillo y suavidad duraderos. Ideal para cabellos tratados químicamente o expuestos al calor.',
    imagen: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop&crop=center',
    rating: 5,
    reviews: 124,
    stock: 15,
    descuento: 18,
    nuevo: true,
    bestseller: false,
    marca: 'Toda Bonita Professional',
    tipoPiel: 'Todo tipo de cabello',
    ingredientes: [
      'Queratina hidrolizada',
      'Aceite de argán orgánico',
      'Complejo vitamínico B',
      'Extracto de aloe vera',
      'Proteínas de seda'
    ],
    modoUso: [
      'Lava el cabello con champú',
      'Aplica una pequeña cantidad en cabello húmedo',
      'Distribuye uniformemente de medios a puntas',
      'No enjuagues y procede con el peinado habitual'
    ]
  },
  {
    id: 2,
    nombre: 'Mascarilla Hidratante Facial',
    precio: 38,
    categoria: 'Skincare',
    icon: '✨',
    descripcion: 'Mascarilla con ácido hialurónico para hidratación profunda y rejuvenecimiento',
    descripcionCompleta: 'Mascarilla facial intensiva con ácido hialurónico de bajo y alto peso molecular, niacinamida y extractos vegetales. Proporciona hidratación profunda de hasta 72 horas, mejora la elasticidad y reduce los signos de fatiga.',
    imagen: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop&crop=center',
    rating: 4,
    reviews: 89,
    stock: 23,
    nuevo: false,
    bestseller: true,
    marca: 'Toda Bonita Skincare',
    tipoPiel: 'Piel seca y mixta',
    ingredientes: [
      'Ácido hialurónico',
      'Niacinamida',
      'Extracto de rosa damascena',
      'Colágeno marino',
      'Vitamina E'
    ],
    modoUso: [
      'Limpia tu rostro profundamente',
      'Aplica una capa uniforme evitando el contorno de ojos',
      'Deja actuar 15-20 minutos',
      'Retira con agua tibia y aplica tu crema habitual'
    ]
  }
  // Agregar más productos según sea necesario
]

// Encontrar el producto actual
const producto = computed(() => {
  return productos.find(p => p.id === productId) || productos[0]
})

// Productos relacionados (misma categoría)
const productosRelacionados = computed(() => {
  return productos
    .filter(p => p.id !== productId && p.categoria === producto.value.categoria)
    .slice(0, 4)
})

// Estado reactivo para cantidad
const quantity = ref(1)

// SEO dinámico
useHead(() => ({
  title: `${producto.value.nombre} - Toda Bonita`,
  meta: [
    { name: 'description', content: producto.value.descripcionCompleta || producto.value.descripcion },
    { name: 'keywords', content: `${producto.value.nombre}, ${producto.value.categoria}, belleza, Toda Bonita` },
    { property: 'og:title', content: `${producto.value.nombre} - Toda Bonita` },
    { property: 'og:description', content: producto.value.descripcion },
    { property: 'og:image', content: producto.value.imagen },
    { property: 'og:type', content: 'product' }
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
const getStockText = (stock) => {
  if (stock === 0) return 'Agotado'
  if (stock <= 5) return `Solo ${stock} disponibles`
  if (stock <= 10) return 'Pocas unidades'
  return 'En stock'
}

const increaseQuantity = () => {
  if (quantity.value < producto.value.stock) {
    quantity.value++
  }
}

const decreaseQuantity = () => {
  if (quantity.value > 1) {
    quantity.value--
  }
}

const addToCart = () => {
  if (producto.value.stock > 0) {
    alert(`${quantity.value} unidad(es) de ${producto.value.nombre} agregado(s) al carrito!`)
  }
}

const addToWishlist = () => {
  alert(`${producto.value.nombre} agregado a favoritos!`)
}
</script>

<style scoped>
/* Estilos adicionales si son necesarios */
</style>