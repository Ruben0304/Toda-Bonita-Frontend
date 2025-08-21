<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/30 to-orange-50/20">
    <!-- Header -->
    <header class="bg-white shadow-sm border-b border-pink-100">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <div class="flex items-center">
            <h1 class="text-2xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
              Panel de Administración
            </h1>
          </div>
          <div class="flex items-center space-x-4">
            <div class="relative">
              <div class="flex items-center space-x-2 bg-pink-50 px-3 py-2 rounded-full">
                <div class="w-8 h-8 bg-gradient-to-r from-pink-500 to-orange-500 rounded-full flex items-center justify-center">
                  <span class="text-white font-bold text-sm">TB</span>
                </div>
                <span class="text-gray-700 font-medium">Admin</span>
              </div>
            </div>
            <NuxtLink to="/" class="text-gray-500 hover:text-pink-500 transition-colors">
              🏠 Ir al sitio
            </NuxtLink>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Stats Overview -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div class="bg-white rounded-2xl p-6 shadow-lg border border-pink-100">
          <div class="flex items-center">
            <div class="p-3 rounded-lg bg-pink-100">
              <span class="text-2xl">📅</span>
            </div>
            <div class="ml-4">
              <p class="text-sm text-gray-500">Reservas Hoy</p>
              <p class="text-2xl font-bold text-gray-900">{{ stats.reservasHoy }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-6 shadow-lg border border-orange-100">
          <div class="flex items-center">
            <div class="p-3 rounded-lg bg-orange-100">
              <span class="text-2xl">⏳</span>
            </div>
            <div class="ml-4">
              <p class="text-sm text-gray-500">Pendientes</p>
              <p class="text-2xl font-bold text-gray-900">{{ stats.reservasPendientes }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-6 shadow-lg border border-green-100">
          <div class="flex items-center">
            <div class="p-3 rounded-lg bg-green-100">
              <span class="text-2xl">🛍️</span>
            </div>
            <div class="ml-4">
              <p class="text-sm text-gray-500">Solicitudes Productos</p>
              <p class="text-2xl font-bold text-gray-900">{{ stats.solicitudesProductos }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-6 shadow-lg border border-purple-100">
          <div class="flex items-center">
            <div class="p-3 rounded-lg bg-purple-100">
              <span class="text-2xl">💰</span>
            </div>
            <div class="ml-4">
              <p class="text-sm text-gray-500">Ingresos Mes</p>
              <p class="text-2xl font-bold text-gray-900">${{ stats.ingresosMes.toLocaleString() }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
        <div class="bg-white rounded-2xl p-6 shadow-lg border border-gray-100">
          <h2 class="text-xl font-bold text-gray-900 mb-4">Acciones Rápidas</h2>
          <div class="grid grid-cols-2 gap-4">
            <button @click="activeTab = 'reservas'" 
                    class="flex items-center justify-center p-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white rounded-xl hover:shadow-lg transition-all duration-300">
              <span class="text-2xl mr-2">📅</span>
              <span class="font-medium">Ver Reservas</span>
            </button>
            
            <button @click="activeTab = 'productos'" 
                    class="flex items-center justify-center p-4 bg-gradient-to-r from-purple-500 to-pink-500 text-white rounded-xl hover:shadow-lg transition-all duration-300">
              <span class="text-2xl mr-2">🛍️</span>
              <span class="font-medium">Solicitudes</span>
            </button>
            
            <button @click="showAddReserva = true" 
                    class="flex items-center justify-center p-4 bg-gradient-to-r from-green-500 to-teal-500 text-white rounded-xl hover:shadow-lg transition-all duration-300">
              <span class="text-2xl mr-2">➕</span>
              <span class="font-medium">Nueva Reserva</span>
            </button>
            
            <button @click="exportData" 
                    class="flex items-center justify-center p-4 bg-gradient-to-r from-blue-500 to-purple-500 text-white rounded-xl hover:shadow-lg transition-all duration-300">
              <span class="text-2xl mr-2">📊</span>
              <span class="font-medium">Exportar</span>
            </button>
          </div>
        </div>

        <!-- Recent Activity -->
        <div class="bg-white rounded-2xl p-6 shadow-lg border border-gray-100">
          <h2 class="text-xl font-bold text-gray-900 mb-4">Actividad Reciente</h2>
          <div class="space-y-3">
            <div v-for="activity in recentActivity" :key="activity.id" 
                 class="flex items-center p-3 bg-gray-50 rounded-lg">
              <div class="p-2 rounded-lg" :class="activity.bgColor">
                <span class="text-lg">{{ activity.icon }}</span>
              </div>
              <div class="ml-3 flex-1">
                <p class="text-sm font-medium text-gray-900">{{ activity.title }}</p>
                <p class="text-xs text-gray-500">{{ activity.time }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Tab Navigation -->
      <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden">
        <div class="border-b border-gray-200">
          <nav class="flex">
            <button @click="activeTab = 'dashboard'" 
                    :class="activeTab === 'dashboard' ? 'border-pink-500 text-pink-600 bg-pink-50' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'"
                    class="w-1/3 py-4 px-6 text-center border-b-2 font-medium text-sm transition-all duration-200">
              📊 Dashboard
            </button>
            <button @click="activeTab = 'reservas'" 
                    :class="activeTab === 'reservas' ? 'border-pink-500 text-pink-600 bg-pink-50' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'"
                    class="w-1/3 py-4 px-6 text-center border-b-2 font-medium text-sm transition-all duration-200">
              📅 Reservas
            </button>
            <button @click="activeTab = 'productos'" 
                    :class="activeTab === 'productos' ? 'border-pink-500 text-pink-600 bg-pink-50' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'"
                    class="w-1/3 py-4 px-6 text-center border-b-2 font-medium text-sm transition-all duration-200">
              🛍️ Productos
            </button>
          </nav>
        </div>

        <!-- Tab Content -->
        <div class="p-6">
          <!-- Dashboard Tab -->
          <div v-if="activeTab === 'dashboard'" class="space-y-6">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <!-- Revenue Chart Placeholder -->
              <div class="bg-gray-50 rounded-xl p-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">Ingresos del Mes</h3>
                <div class="h-64 flex items-center justify-center bg-white rounded-lg border-2 border-dashed border-gray-300">
                  <div class="text-center">
                    <span class="text-4xl mb-2 block">📈</span>
                    <p class="text-gray-500">Gráfico de ingresos</p>
                  </div>
                </div>
              </div>

              <!-- Services Performance -->
              <div class="bg-gray-50 rounded-xl p-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">Servicios Más Populares</h3>
                <div class="space-y-3">
                  <div v-for="service in topServices" :key="service.name" class="flex items-center justify-between p-3 bg-white rounded-lg">
                    <div class="flex items-center">
                      <span class="text-2xl mr-3">{{ service.icon }}</span>
                      <span class="font-medium">{{ service.name }}</span>
                    </div>
                    <span class="text-pink-600 font-bold">{{ service.count }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Reservas Tab -->
          <AdminReservas v-if="activeTab === 'reservas'" />

          <!-- Productos Tab -->
          <AdminProductos v-if="activeTab === 'productos'" />
        </div>
      </div>
    </div>

    <!-- Add Reserva Modal -->
    <div v-if="showAddReserva" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-2xl max-w-md w-full p-6">
        <h3 class="text-xl font-bold text-gray-900 mb-4">Nueva Reserva</h3>
        <form @submit.prevent="addReserva" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Cliente</label>
            <input v-model="newReserva.cliente" type="text" required
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Servicio</label>
            <select v-model="newReserva.servicio" required
                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
              <option value="">Seleccionar servicio</option>
              <option value="Manicure">Manicure</option>
              <option value="Pedicure">Pedicure</option>
              <option value="Facial">Facial</option>
              <option value="Masaje">Masaje</option>
            </select>
          </div>
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Fecha</label>
              <input v-model="newReserva.fecha" type="date" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Hora</label>
              <input v-model="newReserva.hora" type="time" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
          </div>
          <div class="flex space-x-3 pt-4">
            <button type="submit"
                    class="flex-1 bg-gradient-to-r from-pink-500 to-orange-500 text-white py-2 px-4 rounded-lg hover:shadow-lg transition-all duration-300">
              Crear Reserva
            </button>
            <button type="button" @click="showAddReserva = false"
                    class="flex-1 bg-gray-200 text-gray-800 py-2 px-4 rounded-lg hover:bg-gray-300 transition-colors">
              Cancelar
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
useHead({
  title: 'Panel de Administración - Toda Bonita',
  meta: [
    { name: 'description', content: 'Panel de administración para gestionar reservas y solicitudes de productos' }
  ]
})

const activeTab = ref('dashboard')
const showAddReserva = ref(false)

const newReserva = ref({
  cliente: '',
  servicio: '',
  fecha: '',
  hora: ''
})

const stats = ref({
  reservasHoy: 12,
  reservasPendientes: 8,
  solicitudesProductos: 5,
  ingresosMes: 45000
})

const recentActivity = ref([
  {
    id: 1,
    icon: '📅',
    title: 'Nueva reserva de María García',
    time: 'Hace 5 minutos',
    bgColor: 'bg-pink-100'
  },
  {
    id: 2,
    icon: '🛍️',
    title: 'Solicitud de producto actualizada',
    time: 'Hace 15 minutos',
    bgColor: 'bg-purple-100'
  },
  {
    id: 3,
    icon: '✅',
    title: 'Reserva confirmada para Ana López',
    time: 'Hace 30 minutos',
    bgColor: 'bg-green-100'
  },
  {
    id: 4,
    icon: '💰',
    title: 'Pago recibido - $150.000',
    time: 'Hace 1 hora',
    bgColor: 'bg-blue-100'
  }
])

const topServices = ref([
  { name: 'Manicure', icon: '💅', count: 28 },
  { name: 'Facial', icon: '✨', count: 22 },
  { name: 'Pedicure', icon: '🦶', count: 18 },
  { name: 'Masaje', icon: '💆‍♀️', count: 15 }
])

const addReserva = () => {
  // Here you would typically send the data to your backend
  console.log('Nueva reserva:', newReserva.value)
  
  // Add to recent activity
  recentActivity.value.unshift({
    id: Date.now(),
    icon: '📅',
    title: `Nueva reserva de ${newReserva.value.cliente}`,
    time: 'Ahora mismo',
    bgColor: 'bg-pink-100'
  })
  
  // Update stats
  stats.value.reservasPendientes++
  
  // Reset form and close modal
  newReserva.value = {
    cliente: '',
    servicio: '',
    fecha: '',
    hora: ''
  }
  showAddReserva.value = false
}

const exportData = () => {
  // Export functionality would be implemented here
  alert('Función de exportación en desarrollo')
}
</script>

<style scoped>
.gradient-text {
  background: linear-gradient(135deg, #ec4899, #f97316);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
</style>