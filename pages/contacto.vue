<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/10 to-orange-50/5">
    <!-- Hero Section -->
    <section class="py-16 px-6 relative bg-gradient-to-br from-white to-pink-50/20">
      <div class="max-w-6xl mx-auto">
        <div class="text-center mb-12">
          <h1 
            class="text-4xl lg:text-5xl font-bold mb-4"
            data-aos="fade-up"
            data-aos-duration="800"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Contáctanos
            </span>
          </h1>
          <p 
            class="text-lg text-gray-600 max-w-xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="100"
            data-aos-duration="800"
          >
            Estamos aquí para hacer realidad tu transformación. ¡Escribenos!
          </p>
        </div>
      </div>
    </section>

    <!-- Main Content -->
    <section class="py-12 px-6">
      <div class="max-w-6xl mx-auto">
        <div class="grid lg:grid-cols-2 gap-12">
          <!-- Contact Form -->
          <div 
            class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50"
            data-aos="fade-right"
            data-aos-duration="800"
          >
            <h2 class="text-2xl font-bold mb-6 text-gray-800">Envíanos un Mensaje</h2>
            
            <form @submit.prevent="submitForm" class="space-y-6">
              <div class="grid md:grid-cols-2 gap-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Nombre</label>
                  <input
                    v-model="form.nombre"
                    type="text"
                    required
                    class="w-full px-4 py-3 rounded-xl border border-pink-200/50 focus:border-pink-400 focus:outline-none focus:ring-2 focus:ring-pink-100/50 transition-all duration-300"
                    placeholder="Tu nombre"
                  />
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Apellido</label>
                  <input
                    v-model="form.apellido"
                    type="text"
                    required
                    class="w-full px-4 py-3 rounded-xl border border-pink-200/50 focus:border-pink-400 focus:outline-none focus:ring-2 focus:ring-pink-100/50 transition-all duration-300"
                    placeholder="Tu apellido"
                  />
                </div>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                <input
                  v-model="form.email"
                  type="email"
                  required
                  class="w-full px-4 py-3 rounded-xl border border-pink-200/50 focus:border-pink-400 focus:outline-none focus:ring-2 focus:ring-pink-100/50 transition-all duration-300"
                  placeholder="tu@email.com"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Teléfono</label>
                <input
                  v-model="form.telefono"
                  type="tel"
                  class="w-full px-4 py-3 rounded-xl border border-pink-200/50 focus:border-pink-400 focus:outline-none focus:ring-2 focus:ring-pink-100/50 transition-all duration-300"
                  placeholder="+1 234 567 8900"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Servicio de Interés</label>
                <select
                  v-model="form.servicio"
                  class="w-full px-4 py-3 rounded-xl border border-pink-200/50 focus:border-pink-400 focus:outline-none focus:ring-2 focus:ring-pink-100/50 transition-all duration-300"
                >
                  <option value="">Selecciona un servicio</option>
                  <option value="corte-peinado">Corte y Peinado</option>
                  <option value="coloracion">Coloración</option>
                  <option value="tratamiento-facial">Tratamiento Facial</option>
                  <option value="manicure-pedicure">Manicure y Pedicure</option>
                  <option value="extension-pestanas">Extensión de Pestañas</option>
                  <option value="depilacion">Depilación</option>
                  <option value="otro">Otro</option>
                </select>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Mensaje</label>
                <textarea
                  v-model="form.mensaje"
                  rows="5"
                  required
                  class="w-full px-4 py-3 rounded-xl border border-pink-200/50 focus:border-pink-400 focus:outline-none focus:ring-2 focus:ring-pink-100/50 transition-all duration-300 resize-none"
                  placeholder="Cuéntanos sobre tu transformación ideal..."
                ></textarea>
              </div>

              <button
                type="submit"
                :disabled="isSubmitting"
                class="w-full py-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-bold rounded-2xl shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                <span v-if="!isSubmitting" class="flex items-center justify-center space-x-2">
                  <Icon name="lucide:send" class="w-5 h-5" />
                  <span>Enviar Mensaje</span>
                </span>
                <span v-else class="flex items-center justify-center space-x-2">
                  <div class="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                  <span>Enviando...</span>
                </span>
              </button>
            </form>
          </div>

          <!-- Contact Information -->
          <div class="space-y-8">
            <!-- Info Cards -->
            <div 
              class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50"
              data-aos="fade-left"
              data-aos-duration="800"
            >
              <h3 class="text-2xl font-bold mb-6 bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
                Información de Contacto
              </h3>
              
              <div class="space-y-6">
                <div class="flex items-center">
                  <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                    <Icon name="lucide:map-pin" class="w-6 h-6 text-white" />
                  </div>
                  <div>
                    <p class="font-semibold text-gray-800">Dirección</p>
                    <p class="text-gray-600">Av. Belleza 123, Centro</p>
                    <p class="text-gray-600">Ciudad de México, CDMX 01234</p>
                  </div>
                </div>
                
                <div class="flex items-center">
                  <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                    <Icon name="lucide:phone" class="w-6 h-6 text-white" />
                  </div>
                  <div>
                    <p class="font-semibold text-gray-800">Teléfono</p>
                    <p class="text-gray-600">+52 55 1234 5678</p>
                    <p class="text-gray-600">+52 55 8765 4321</p>
                  </div>
                </div>
                
                <div class="flex items-center">
                  <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                    <Icon name="lucide:mail" class="w-6 h-6 text-white" />
                  </div>
                  <div>
                    <p class="font-semibold text-gray-800">Email</p>
                    <p class="text-gray-600">hola@todabonita.com</p>
                    <p class="text-gray-600">citas@todabonita.com</p>
                  </div>
                </div>
                
                <div class="flex items-center">
                  <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                    <Icon name="lucide:clock" class="w-6 h-6 text-white" />
                  </div>
                  <div>
                    <p class="font-semibold text-gray-800">Horario</p>
                    <p class="text-gray-600">Lun - Vie: 9:00 AM - 8:00 PM</p>
                    <p class="text-gray-600">Sáb: 9:00 AM - 6:00 PM</p>
                    <p class="text-gray-600">Dom: 10:00 AM - 5:00 PM</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Social Media -->
            <div 
              class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50"
              data-aos="fade-left"
              data-aos-delay="200"
              data-aos-duration="800"
            >
              <h3 class="text-2xl font-bold mb-6 bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
                Síguenos
              </h3>
              
              <div class="grid grid-cols-2 gap-4">
                <button 
                  @click="openSocial('instagram')"
                  class="flex items-center justify-center space-x-3 p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-105 group border border-pink-200/50"
                >
                  <Icon name="lucide:instagram" class="w-6 h-6 text-pink-600 group-hover:scale-110 transition-transform" />
                  <span class="font-medium text-gray-700">Instagram</span>
                </button>
                
                <button 
                  @click="openSocial('facebook')"
                  class="flex items-center justify-center space-x-3 p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-105 group border border-pink-200/50"
                >
                  <Icon name="lucide:facebook" class="w-6 h-6 text-pink-600 group-hover:scale-110 transition-transform" />
                  <span class="font-medium text-gray-700">Facebook</span>
                </button>
                
                <button 
                  @click="openSocial('tiktok')"
                  class="flex items-center justify-center space-x-3 p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-105 group border border-pink-200/50"
                >
                  <Icon name="lucide:music" class="w-6 h-6 text-pink-600 group-hover:scale-110 transition-transform" />
                  <span class="font-medium text-gray-700">TikTok</span>
                </button>
                
                <button 
                  @click="openSocial('whatsapp')"
                  class="flex items-center justify-center space-x-3 p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-105 group border border-pink-200/50"
                >
                  <Icon name="lucide:message-circle" class="w-6 h-6 text-pink-600 group-hover:scale-110 transition-transform" />
                  <span class="font-medium text-gray-700">WhatsApp</span>
                </button>
              </div>
            </div>

            <!-- Quick Actions -->
            <div 
              class="bg-gradient-to-br from-pink-50 to-orange-50 rounded-3xl p-8 border border-pink-200/50"
              data-aos="fade-left"
              data-aos-delay="400"
              data-aos-duration="800"
            >
              <h3 class="text-xl font-bold mb-6 text-gray-800 text-center">
                ¿Prefieres una acción rápida?
              </h3>
              
              <div class="space-y-4">
                <NuxtLink to="/reserva" class="block">
                  <button class="w-full py-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-bold rounded-2xl shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                    <span class="flex items-center justify-center space-x-2">
                      <Icon name="lucide:calendar-plus" class="w-5 h-5" />
                      <span>Reservar Cita Online</span>
                    </span>
                  </button>
                </NuxtLink>
                
                <button 
                  @click="callDirectly"
                  class="w-full py-4 bg-white border-2 border-pink-300 text-pink-600 font-bold rounded-2xl shadow-md hover:shadow-lg hover:bg-pink-50 transform hover:scale-105 transition-all duration-300"
                >
                  <span class="flex items-center justify-center space-x-2">
                    <Icon name="lucide:phone-call" class="w-5 h-5" />
                    <span>Llamar Ahora</span>
                  </span>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Map Section -->
    <section class="py-12 px-6 bg-gradient-to-r from-white via-pink-50/10 to-orange-50/10">
      <div class="max-w-6xl mx-auto">
        <div 
          class="bg-white rounded-3xl overflow-hidden shadow-lg border border-pink-100/50"
          data-aos="fade-up"
          data-aos-duration="800"
        >
          <div class="p-8 text-center">
            <h3 class="text-2xl font-bold mb-4 bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
              Encuéntranos
            </h3>
            <p class="text-gray-600 mb-6">
              Estamos ubicados en el corazón de la ciudad, fácil acceso en transporte público
            </p>
          </div>
          
          <!-- Map Placeholder -->
          <div class="relative h-96 bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
            <div class="text-center">
              <Icon name="lucide:map" class="w-16 h-16 text-gray-400 mx-auto mb-4" />
              <p class="text-gray-500 font-medium">Mapa Interactivo</p>
              <p class="text-sm text-gray-400">Av. Belleza 123, Centro, CDMX</p>
              <button 
                @click="openMaps"
                class="mt-4 px-6 py-3 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-semibold rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300"
              >
                Ver en Google Maps
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Success/Error Messages -->
    <div 
      v-if="showMessage"
      class="fixed bottom-6 right-6 z-50 max-w-sm"
      data-aos="slide-left"
      data-aos-duration="500"
    >
      <div 
        :class="[
          'p-4 rounded-2xl shadow-xl border-l-4',
          messageType === 'success' 
            ? 'bg-green-50 border-green-500 text-green-700' 
            : 'bg-red-50 border-red-500 text-red-700'
        ]"
      >
        <div class="flex items-center">
          <Icon 
            :name="messageType === 'success' ? 'lucide:check-circle' : 'lucide:x-circle'" 
            class="w-5 h-5 mr-3" 
          />
          <div>
            <p class="font-semibold">{{ messageTitle }}</p>
            <p class="text-sm">{{ messageText }}</p>
          </div>
          <button @click="showMessage = false" class="ml-4">
            <Icon name="lucide:x" class="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
// SEO
useHead({
  title: 'Contacto - Toda Bonita',
  meta: [
    { name: 'description', content: 'Contáctanos para agendar tu cita o resolver cualquier duda. Estamos aquí para hacer realidad tu transformación de belleza.' },
    { name: 'keywords', content: 'contacto, citas, salon de belleza, ubicacion, telefono, email, Toda Bonita' },
    { property: 'og:title', content: 'Contacto - Toda Bonita' },
    { property: 'og:description', content: 'Estamos aquí para hacer realidad tu transformación' },
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
const form = ref({
  nombre: '',
  apellido: '',
  email: '',
  telefono: '',
  servicio: '',
  mensaje: ''
})

const isSubmitting = ref(false)
const showMessage = ref(false)
const messageType = ref('success')
const messageTitle = ref('')
const messageText = ref('')

// Funciones
const submitForm = async () => {
  isSubmitting.value = true
  
  try {
    // Simular envío del formulario
    await new Promise(resolve => setTimeout(resolve, 2000))
    
    // Mostrar mensaje de éxito
    showSuccessMessage('¡Mensaje enviado!', 'Te contactaremos pronto para confirmar tu cita.')
    
    // Limpiar formulario
    form.value = {
      nombre: '',
      apellido: '',
      email: '',
      telefono: '',
      servicio: '',
      mensaje: ''
    }
  } catch (error) {
    showErrorMessage('Error al enviar', 'Por favor intenta nuevamente o llámanos directamente.')
  } finally {
    isSubmitting.value = false
  }
}

const showSuccessMessage = (title, text) => {
  messageType.value = 'success'
  messageTitle.value = title
  messageText.value = text
  showMessage.value = true
  
  setTimeout(() => {
    showMessage.value = false
  }, 5000)
}

const showErrorMessage = (title, text) => {
  messageType.value = 'error'
  messageTitle.value = title
  messageText.value = text
  showMessage.value = true
  
  setTimeout(() => {
    showMessage.value = false
  }, 5000)
}

const openSocial = (platform) => {
  const urls = {
    instagram: 'https://instagram.com/todabonita',
    facebook: 'https://facebook.com/todabonita',
    tiktok: 'https://tiktok.com/@todabonita',
    whatsapp: 'https://wa.me/525512345678'
  }
  
  if (urls[platform]) {
    window.open(urls[platform], '_blank')
  }
}

const callDirectly = () => {
  window.open('tel:+525512345678', '_self')
}

const openMaps = () => {
  window.open('https://maps.google.com/?q=Av.+Belleza+123,+Centro,+CDMX', '_blank')
}
</script>

<style scoped>
/* Estilos adicionales si son necesarios */
</style>