<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/20 to-orange-50/10">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Header -->
      <div class="text-center mb-8">
        <h1 class="text-4xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent mb-4">
          Reserva tu Cita
        </h1>
        <p class="text-gray-600 max-w-2xl mx-auto">
          Reserva tu cita de belleza en unos simples pasos. Nuestro equipo de profesionales está listo para brindarte la mejor experiencia.
        </p>
      </div>

      <!-- Progress Indicator -->
      <div class="mb-8">
        <div class="flex items-center justify-center">
          <div v-for="(step, index) in steps" :key="index" class="flex items-center">
            <div :class="index < currentStep ? 'bg-pink-500 text-white' : index === currentStep ? 'bg-pink-500 text-white' : 'bg-gray-200 text-gray-500'"
                 class="w-10 h-10 rounded-full flex items-center justify-center font-bold transition-colors duration-300">
              {{ index + 1 }}
            </div>
            <div v-if="index < steps.length - 1" 
                 :class="index < currentStep ? 'bg-pink-500' : 'bg-gray-200'"
                 class="w-16 h-1 mx-2 transition-colors duration-300">
            </div>
          </div>
        </div>
        <div class="flex justify-center mt-4">
          <span class="text-sm text-gray-600 font-medium">{{ steps[currentStep] }}</span>
        </div>
      </div>

      <!-- Form Container -->
      <div class="bg-white rounded-3xl shadow-xl p-8">
        <form @submit.prevent="nextStep">
          <!-- Step 1: Servicio -->
          <div v-if="currentStep === 0" class="space-y-6">
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Selecciona tu Servicio</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div v-for="servicio in servicios" :key="servicio.id"
                   @click="selectService(servicio)"
                   :class="reservation.servicio?.id === servicio.id ? 'border-pink-500 bg-pink-50' : 'border-gray-200 hover:border-pink-300'"
                   class="border-2 rounded-2xl p-6 cursor-pointer transition-all duration-300 hover:shadow-md">
                <div class="flex items-center space-x-4">
                  <span class="text-3xl">{{ servicio.icono }}</span>
                  <div class="flex-1">
                    <h3 class="font-bold text-gray-900">{{ servicio.nombre }}</h3>
                    <p class="text-gray-600 text-sm mb-2">{{ servicio.descripcion }}</p>
                    <div class="flex items-center justify-between">
                      <span class="text-pink-600 font-bold">${{ servicio.precio.toLocaleString() }}</span>
                      <span class="text-gray-500 text-sm">{{ servicio.duracion }} min</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Step 2: Fecha y Hora -->
          <div v-if="currentStep === 1" class="space-y-6">
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Fecha y Hora</h2>
            
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
              <!-- Calendar -->
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Selecciona la Fecha</label>
                <input v-model="reservation.fecha" 
                       type="date" 
                       :min="minDate"
                       required
                       class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-500">
              </div>

              <!-- Time Slots -->
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Hora Disponible</label>
                <div class="grid grid-cols-3 gap-2 max-h-64 overflow-y-auto">
                  <button v-for="hora in horasDisponibles" :key="hora"
                          @click.prevent="selectTime(hora)"
                          :class="reservation.hora === hora ? 'bg-pink-500 text-white' : 'bg-gray-100 text-gray-700 hover:bg-pink-100'"
                          class="py-2 px-3 rounded-lg text-sm font-medium transition-colors duration-200">
                    {{ hora }}
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- Step 3: Información Personal -->
          <div v-if="currentStep === 2" class="space-y-6">
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Información Personal</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Nombre Completo</label>
                <input v-model="reservation.nombre" 
                       type="text" 
                       required
                       class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-500">
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Teléfono</label>
                <input v-model="reservation.telefono" 
                       type="tel" 
                       required
                       class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-500">
              </div>
              
              <div class="md:col-span-2">
                <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                <input v-model="reservation.email" 
                       type="email" 
                       required
                       class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-500">
              </div>
              
              <div class="md:col-span-2">
                <label class="block text-sm font-medium text-gray-700 mb-2">Notas Especiales (Opcional)</label>
                <textarea v-model="reservation.notas" 
                          rows="3"
                          class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-500"></textarea>
              </div>
            </div>
          </div>

          <!-- Step 4: Confirmación -->
          <div v-if="currentStep === 3" class="space-y-6">
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Confirma tu Reserva</h2>
            
            <div class="bg-gray-50 rounded-2xl p-6">
              <h3 class="font-bold text-gray-900 mb-4">Resumen de tu Cita</h3>
              
              <div class="space-y-3">
                <div class="flex justify-between items-center py-2 border-b border-gray-200">
                  <span class="text-gray-600">Servicio:</span>
                  <span class="font-medium">{{ reservation.servicio?.nombre }}</span>
                </div>
                
                <div class="flex justify-between items-center py-2 border-b border-gray-200">
                  <span class="text-gray-600">Fecha:</span>
                  <span class="font-medium">{{ formatDate(reservation.fecha) }}</span>
                </div>
                
                <div class="flex justify-between items-center py-2 border-b border-gray-200">
                  <span class="text-gray-600">Hora:</span>
                  <span class="font-medium">{{ reservation.hora }}</span>
                </div>
                
                <div class="flex justify-between items-center py-2 border-b border-gray-200">
                  <span class="text-gray-600">Duración:</span>
                  <span class="font-medium">{{ reservation.servicio?.duracion }} minutos</span>
                </div>
                
                <div class="flex justify-between items-center py-2 border-b border-gray-200">
                  <span class="text-gray-600">Cliente:</span>
                  <span class="font-medium">{{ reservation.nombre }}</span>
                </div>
                
                <div class="flex justify-between items-center py-2 border-b border-gray-200">
                  <span class="text-gray-600">Teléfono:</span>
                  <span class="font-medium">{{ reservation.telefono }}</span>
                </div>
                
                <div class="flex justify-between items-center py-3 bg-pink-50 px-4 rounded-xl mt-4">
                  <span class="text-gray-900 font-bold">Total:</span>
                  <span class="text-2xl font-bold text-pink-600">${{ reservation.servicio?.precio.toLocaleString() }}</span>
                </div>
              </div>
            </div>

            <div class="bg-blue-50 border border-blue-200 rounded-xl p-4">
              <h4 class="font-bold text-blue-900 mb-2">📋 Información Importante</h4>
              <ul class="text-sm text-blue-800 space-y-1">
                <li>• Llega 10 minutos antes de tu cita</li>
                <li>• Recibirás un SMS de confirmación</li>
                <li>• Política de cancelación: 24 horas antes</li>
                <li>• Trae una identificación válida</li>
              </ul>
            </div>
          </div>

          <!-- Navigation Buttons -->
          <div class="flex justify-between items-center mt-8 pt-6 border-t border-gray-200">
            <button v-if="currentStep > 0" 
                    @click.prevent="previousStep"
                    type="button"
                    class="px-6 py-3 border border-gray-300 text-gray-700 rounded-xl hover:bg-gray-50 transition-colors duration-200">
              ← Anterior
            </button>
            <div v-else></div>

            <button type="submit"
                    :disabled="!canProceed"
                    :class="canProceed ? 'bg-gradient-to-r from-pink-500 to-orange-500 hover:shadow-lg' : 'bg-gray-300 cursor-not-allowed'"
                    class="px-8 py-3 text-white rounded-xl font-medium transition-all duration-300">
              {{ currentStep === 3 ? '✅ Confirmar Reserva' : 'Siguiente →' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
useHead({
  title: 'Reservar Cita - Toda Bonita',
  meta: [
    { name: 'description', content: 'Reserva tu cita de belleza en Toda Bonita. Proceso fácil y rápido en 4 simples pasos.' }
  ]
})

const currentStep = ref(0)
const steps = [
  'Selecciona Servicio',
  'Fecha y Hora', 
  'Información Personal',
  'Confirmación'
]

const reservation = ref({
  servicio: null,
  fecha: '',
  hora: '',
  nombre: '',
  telefono: '',
  email: '',
  notas: ''
})

const servicios = ref([
  {
    id: 1,
    nombre: 'Manicure Clásico',
    descripcion: 'Cuidado completo de uñas con esmaltado',
    precio: 45000,
    duracion: 60,
    icono: '💅'
  },
  {
    id: 2,
    nombre: 'Pedicure Spa',
    descripcion: 'Relajación y cuidado para tus pies',
    precio: 55000,
    duracion: 75,
    icono: '🦶'
  },
  {
    id: 3,
    nombre: 'Facial Hidratante',
    descripcion: 'Tratamiento facial profundo e hidratante',
    precio: 80000,
    duracion: 90,
    icono: '✨'
  },
  {
    id: 4,
    nombre: 'Masaje Relajante',
    descripcion: 'Masaje corporal para aliviar tensiones',
    precio: 120000,
    duracion: 120,
    icono: '💆‍♀️'
  },
  {
    id: 5,
    nombre: 'Maquillaje Profesional',
    descripcion: 'Maquillaje para eventos especiales',
    precio: 100000,
    duracion: 90,
    icono: '💄'
  },
  {
    id: 6,
    nombre: 'Depilación Completa',
    descripcion: 'Depilación con cera de piernas completas',
    precio: 70000,
    duracion: 60,
    icono: '🪒'
  }
])

const horasDisponibles = ref([
  '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
  '14:00', '14:30', '15:00', '15:30', '16:00', '16:30',
  '17:00', '17:30', '18:00', '18:30'
])

const minDate = computed(() => {
  const tomorrow = new Date()
  tomorrow.setDate(tomorrow.getDate() + 1)
  return tomorrow.toISOString().split('T')[0]
})

const canProceed = computed(() => {
  switch (currentStep.value) {
    case 0:
      return reservation.value.servicio !== null
    case 1:
      return reservation.value.fecha && reservation.value.hora
    case 2:
      return reservation.value.nombre && reservation.value.telefono && reservation.value.email
    case 3:
      return true
    default:
      return false
  }
})

const selectService = (servicio) => {
  reservation.value.servicio = servicio
}

const selectTime = (hora) => {
  reservation.value.hora = hora
}

const nextStep = () => {
  if (currentStep.value < 3) {
    currentStep.value++
  } else {
    // Submit reservation
    submitReservation()
  }
}

const previousStep = () => {
  if (currentStep.value > 0) {
    currentStep.value--
  }
}

const formatDate = (dateStr) => {
  if (!dateStr) return ''
  const date = new Date(dateStr)
  return date.toLocaleDateString('es-ES', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const submitReservation = () => {
  // Here you would typically send the reservation to your backend
  console.log('Reserva enviada:', reservation.value)
  
  // Show success message and redirect
  alert('¡Reserva confirmada! Recibirás un SMS de confirmación pronto.')
  navigateTo('/')
}
</script>