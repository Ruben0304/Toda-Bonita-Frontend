<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/10 to-orange-50/5">
    <!-- Hero Section -->
    <section class="py-16 px-6 relative bg-gradient-to-br from-white to-pink-50/20">
      <div class="max-w-4xl mx-auto">
        <div class="text-center mb-12">
          <h1 
            class="text-4xl lg:text-5xl font-bold mb-4"
            data-aos="fade-up"
            data-aos-duration="800"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Carrito de Compras
            </span>
          </h1>
          <p 
            class="text-lg text-gray-600 max-w-xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="100"
            data-aos-duration="800"
          >
            Revisa tus productos seleccionados y finaliza tu compra
          </p>
        </div>
      </div>
    </section>

    <!-- Main Content -->
    <section class="py-12 px-6">
      <div class="max-w-6xl mx-auto">
        <div v-if="cartItems.length === 0" class="text-center py-16">
          <!-- Empty Cart -->
          <div 
            class="bg-white rounded-3xl p-12 shadow-lg border border-pink-100/50"
            data-aos="fade-up"
            data-aos-duration="800"
          >
            <div class="text-6xl mb-6">🛒</div>
            <h2 class="text-2xl font-bold text-gray-600 mb-4">Tu carrito está vacío</h2>
            <p class="text-gray-500 mb-8">¡Agrega algunos productos increíbles a tu carrito!</p>
            <NuxtLink to="/productos">
              <button class="px-8 py-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-bold rounded-2xl shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                <span class="flex items-center space-x-2">
                  <Icon name="lucide:shopping-bag" class="w-5 h-5" />
                  <span>Explorar Productos</span>
                </span>
              </button>
            </NuxtLink>
          </div>
        </div>

        <div v-else class="grid lg:grid-cols-3 gap-8">
          <!-- Cart Items -->
          <div class="lg:col-span-2 space-y-6">
            <div 
              class="bg-white rounded-3xl p-6 shadow-lg border border-pink-100/50"
              data-aos="fade-right"
              data-aos-duration="800"
            >
              <div class="flex items-center justify-between mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Productos ({{ totalItems }})</h2>
                <button 
                  @click="clearCart"
                  class="text-sm text-gray-500 hover:text-red-500 transition-colors"
                >
                  Vaciar carrito
                </button>
              </div>

              <div class="space-y-4">
                <div 
                  v-for="item in cartItems" 
                  :key="item.id"
                  class="flex items-center space-x-4 p-4 border border-pink-100/50 rounded-2xl hover:shadow-md transition-all duration-300"
                >
                  <!-- Product Image -->
                  <img 
                    :src="item.imagen" 
                    :alt="item.nombre"
                    class="w-20 h-20 object-cover rounded-xl"
                  />

                  <!-- Product Info -->
                  <div class="flex-1">
                    <h3 class="font-semibold text-gray-800 mb-1">{{ item.nombre }}</h3>
                    <p class="text-sm text-gray-500 mb-2">{{ item.categoria }}</p>
                    <div class="flex items-center space-x-2">
                      <span 
                        v-if="item.precioOriginal"
                        class="text-sm text-gray-400 line-through"
                      >
                        ${{ item.precioOriginal }}
                      </span>
                      <span class="text-lg font-bold text-pink-600">
                        ${{ item.precio }}
                      </span>
                    </div>
                  </div>

                  <!-- Quantity Controls -->
                  <div class="flex items-center border border-pink-200 rounded-xl">
                    <button 
                      @click="updateQuantity(item.id, item.quantity - 1)"
                      :disabled="item.quantity <= 1"
                      class="p-2 text-pink-600 hover:bg-pink-50 disabled:text-gray-400 disabled:cursor-not-allowed transition-colors rounded-l-xl"
                    >
                      <Icon name="lucide:minus" class="w-4 h-4" />
                    </button>
                    <span class="px-4 py-2 font-semibold min-w-[3rem] text-center">{{ item.quantity }}</span>
                    <button 
                      @click="updateQuantity(item.id, item.quantity + 1)"
                      :disabled="item.quantity >= item.stock"
                      class="p-2 text-pink-600 hover:bg-pink-50 disabled:text-gray-400 disabled:cursor-not-allowed transition-colors rounded-r-xl"
                    >
                      <Icon name="lucide:plus" class="w-4 h-4" />
                    </button>
                  </div>

                  <!-- Subtotal -->
                  <div class="text-right">
                    <p class="text-lg font-bold text-gray-800">
                      ${{ (item.precio * item.quantity).toFixed(2) }}
                    </p>
                  </div>

                  <!-- Remove Button -->
                  <button 
                    @click="removeFromCart(item.id)"
                    class="p-2 text-gray-400 hover:text-red-500 transition-colors"
                    title="Eliminar producto"
                  >
                    <Icon name="lucide:trash-2" class="w-5 h-5" />
                  </button>
                </div>
              </div>
            </div>

            <!-- Recommended Products -->
            <div 
              class="bg-white rounded-3xl p-6 shadow-lg border border-pink-100/50"
              data-aos="fade-right"
              data-aos-delay="200"
              data-aos-duration="800"
            >
              <h3 class="text-xl font-bold text-gray-800 mb-4">Te podría interesar</h3>
              <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
                <div 
                  v-for="product in recommendedProducts" 
                  :key="product.id"
                  class="group cursor-pointer"
                  @click="addToCart(product)"
                >
                  <div class="bg-gray-50 rounded-2xl p-4 hover:shadow-md transition-all duration-300 group-hover:bg-pink-50">
                    <img 
                      :src="product.imagen" 
                      :alt="product.nombre"
                      class="w-full h-24 object-cover rounded-xl mb-3"
                    />
                    <h4 class="font-medium text-sm text-gray-800 mb-1">{{ product.nombre }}</h4>
                    <p class="text-pink-600 font-bold text-sm">${{ product.precio }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Order Summary -->
          <div class="space-y-6">
            <div 
              class="bg-white rounded-3xl p-6 shadow-lg border border-pink-100/50 sticky top-6"
              data-aos="fade-left"
              data-aos-duration="800"
            >
              <h3 class="text-xl font-bold text-gray-800 mb-6">Resumen del Pedido</h3>
              
              <!-- Order Details -->
              <div class="space-y-4 mb-6">
                <div class="flex justify-between text-gray-600">
                  <span>Subtotal ({{ totalItems }} productos)</span>
                  <span>${{ subtotal.toFixed(2) }}</span>
                </div>
                
                <div class="flex justify-between text-gray-600">
                  <span>Envío</span>
                  <span v-if="subtotal >= 50" class="text-green-600 font-semibold">Gratis</span>
                  <span v-else>${{ shipping.toFixed(2) }}</span>
                </div>
                
                <div v-if="discount > 0" class="flex justify-between text-green-600">
                  <span>Descuento</span>
                  <span>-${{ discount.toFixed(2) }}</span>
                </div>
                
                <hr class="border-pink-100">
                
                <div class="flex justify-between text-lg font-bold text-gray-800">
                  <span>Total</span>
                  <span>${{ total.toFixed(2) }}</span>
                </div>
              </div>

              <!-- Promo Code -->
              <div class="mb-6">
                <div class="flex space-x-2">
                  <input
                    v-model="promoCode"
                    type="text"
                    placeholder="Código promocional"
                    class="flex-1 px-4 py-3 border border-pink-200/50 rounded-xl focus:border-pink-400 focus:outline-none focus:ring-2 focus:ring-pink-100/50 transition-all duration-300 text-sm"
                  />
                  <button 
                    @click="applyPromoCode"
                    :disabled="!promoCode.trim()"
                    class="px-4 py-3 bg-gray-100 text-gray-600 rounded-xl hover:bg-gray-200 disabled:opacity-50 disabled:cursor-not-allowed transition-colors text-sm font-medium"
                  >
                    Aplicar
                  </button>
                </div>
                <p v-if="promoMessage" :class="[
                  'text-xs mt-2',
                  promoSuccess ? 'text-green-600' : 'text-red-500'
                ]">
                  {{ promoMessage }}
                </p>
              </div>

              <!-- Shipping Info -->
              <div class="bg-gradient-to-br from-pink-50 to-orange-50/50 rounded-2xl p-4 mb-6">
                <div class="flex items-center space-x-2 mb-2">
                  <Icon name="lucide:truck" class="w-4 h-4 text-pink-500" />
                  <span class="text-sm font-semibold text-gray-700">Información de envío</span>
                </div>
                <p class="text-xs text-gray-600">
                  <span v-if="subtotal >= 50" class="text-green-600 font-semibold">
                    ¡Envío gratis! 
                  </span>
                  <span v-else>
                    Agrega ${{ (50 - subtotal).toFixed(2) }} más para envío gratis
                  </span>
                </p>
                <p class="text-xs text-gray-500 mt-1">
                  Entrega estimada: 2-3 días hábiles
                </p>
              </div>

              <!-- Checkout Button -->
              <button 
                @click="proceedToCheckout"
                :disabled="cartItems.length === 0"
                class="w-full py-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-bold rounded-2xl shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none"
              >
                <span class="flex items-center justify-center space-x-2">
                  <Icon name="lucide:credit-card" class="w-5 h-5" />
                  <span>Proceder al Pago</span>
                </span>
              </button>

              <!-- Security Info -->
              <div class="mt-4 text-center">
                <div class="flex items-center justify-center space-x-2 text-xs text-gray-500">
                  <Icon name="lucide:shield-check" class="w-4 h-4" />
                  <span>Pago 100% seguro y encriptado</span>
                </div>
              </div>
            </div>

            <!-- Customer Support -->
            <div 
              class="bg-gradient-to-br from-pink-50 to-orange-50 rounded-3xl p-6 border border-pink-200/50"
              data-aos="fade-left"
              data-aos-delay="200"
              data-aos-duration="800"
            >
              <h4 class="font-bold text-gray-800 mb-3">¿Necesitas ayuda?</h4>
              <p class="text-sm text-gray-600 mb-4">
                Nuestro equipo está aquí para ayudarte con tu compra
              </p>
              <div class="space-y-2">
                <NuxtLink to="/contacto" class="block">
                  <button class="w-full py-3 bg-white border border-pink-300 text-pink-600 font-semibold rounded-xl hover:bg-pink-50 transition-colors text-sm">
                    <span class="flex items-center justify-center space-x-2">
                      <Icon name="lucide:message-circle" class="w-4 h-4" />
                      <span>Contactar Soporte</span>
                    </span>
                  </button>
                </NuxtLink>
                
                <button 
                  @click="callSupport"
                  class="w-full py-3 bg-white border border-pink-300 text-pink-600 font-semibold rounded-xl hover:bg-pink-50 transition-colors text-sm"
                >
                  <span class="flex items-center justify-center space-x-2">
                    <Icon name="lucide:phone" class="w-4 h-4" />
                    <span>Llamar: +52 55 1234 5678</span>
                  </span>
                </button>
              </div>
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
  title: 'Carrito - Toda Bonita',
  meta: [
    { name: 'description', content: 'Revisa y finaliza tu compra de productos de belleza en Toda Bonita. Envío gratis en compras mayores a $50.' },
    { name: 'keywords', content: 'carrito, compras, productos belleza, checkout, Toda Bonita' },
    { property: 'og:title', content: 'Carrito - Toda Bonita' },
    { property: 'og:description', content: 'Finaliza tu compra de productos de belleza' },
    { property: 'og:type', content: 'website' }
  ]
})

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

// Estado reactivo
const cartItems = ref([
  {
    id: 1,
    nombre: 'Serum Capilar Reparador Premium',
    precio: 45,
    precioOriginal: 55,
    categoria: 'Cabello',
    imagen: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop&crop=center',
    quantity: 2,
    stock: 15
  },
  {
    id: 2,
    nombre: 'Mascarilla Hidratante Facial',
    precio: 38,
    categoria: 'Skincare',
    imagen: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=300&h=300&fit=crop&crop=center',
    quantity: 1,
    stock: 23
  },
  {
    id: 4,
    nombre: 'Crema Anti-edad Vitamina C',
    precio: 68,
    precioOriginal: 85,
    categoria: 'Skincare',
    imagen: 'https://images.unsplash.com/photo-1570194065650-d99fb4bedf0a?w=300&h=300&fit=crop&crop=center',
    quantity: 1,
    stock: 12
  }
])

const promoCode = ref('')
const promoMessage = ref('')
const promoSuccess = ref(false)
const discount = ref(0)

const recommendedProducts = [
  {
    id: 3,
    nombre: 'Aceite de Argán Premium',
    precio: 52,
    imagen: 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=200&h=200&fit=crop&crop=center'
  },
  {
    id: 5,
    nombre: 'Protector Térmico',
    precio: 35,
    imagen: 'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=200&h=200&fit=crop&crop=center'
  },
  {
    id: 6,
    nombre: 'Tónico Facial Balance',
    precio: 28,
    imagen: 'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=200&h=200&fit=crop&crop=center'
  }
]

// Computed properties
const totalItems = computed(() => {
  return cartItems.value.reduce((total, item) => total + item.quantity, 0)
})

const subtotal = computed(() => {
  return cartItems.value.reduce((total, item) => total + (item.precio * item.quantity), 0)
})

const shipping = computed(() => {
  return subtotal.value >= 50 ? 0 : 10
})

const total = computed(() => {
  return subtotal.value + shipping.value - discount.value
})

// Methods
const updateQuantity = (itemId, newQuantity) => {
  if (newQuantity <= 0) return
  
  const item = cartItems.value.find(item => item.id === itemId)
  if (item && newQuantity <= item.stock) {
    item.quantity = newQuantity
  }
}

const removeFromCart = (itemId) => {
  const index = cartItems.value.findIndex(item => item.id === itemId)
  if (index > -1) {
    cartItems.value.splice(index, 1)
  }
}

const clearCart = () => {
  if (confirm('¿Estás seguro de que quieres vaciar el carrito?')) {
    cartItems.value = []
    discount.value = 0
    promoCode.value = ''
    promoMessage.value = ''
  }
}

const addToCart = (product) => {
  const existingItem = cartItems.value.find(item => item.id === product.id)
  
  if (existingItem) {
    if (existingItem.quantity < product.stock) {
      existingItem.quantity++
    } else {
      alert('No hay más stock disponible')
    }
  } else {
    cartItems.value.push({
      ...product,
      quantity: 1,
      stock: 20 // Default stock
    })
  }
}

const applyPromoCode = () => {
  const code = promoCode.value.trim().toLowerCase()
  
  // Códigos promocionales simulados
  const promoCodes = {
    'belleza10': { discount: 10, type: 'percentage' },
    'nuevo15': { discount: 15, type: 'percentage' },
    'envio5': { discount: 5, type: 'fixed' }
  }
  
  if (promoCodes[code]) {
    const promo = promoCodes[code]
    if (promo.type === 'percentage') {
      discount.value = subtotal.value * (promo.discount / 100)
      promoMessage.value = `¡Descuento del ${promo.discount}% aplicado!`
    } else {
      discount.value = promo.discount
      promoMessage.value = `¡Descuento de $${promo.discount} aplicado!`
    }
    promoSuccess.value = true
  } else {
    promoMessage.value = 'Código promocional inválido'
    promoSuccess.value = false
    discount.value = 0
  }
  
  setTimeout(() => {
    promoMessage.value = ''
  }, 3000)
}

const proceedToCheckout = () => {
  // Simular proceso de checkout
  alert('Redirigiendo al checkout seguro...')
}

const callSupport = () => {
  window.open('tel:+525512345678', '_self')
}
</script>

<style scoped>
/* Estilos adicionales si son necesarios */
</style>