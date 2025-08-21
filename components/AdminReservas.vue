<template>
  <div class="space-y-6">
    <!-- Filters and Search -->
    <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between space-y-4 lg:space-y-0">
      <div class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-4">
        <div class="relative">
          <input v-model="searchTerm" type="text" placeholder="Buscar por cliente o servicio..."
                 class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500 w-full sm:w-64">
          <span class="absolute left-3 top-2.5 text-gray-400">🔍</span>
        </div>
        
        <select v-model="filterStatus" 
                class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
          <option value="">Todos los estados</option>
          <option value="pendiente">Pendiente</option>
          <option value="confirmada">Confirmada</option>
          <option value="en-proceso">En Proceso</option>
          <option value="completada">Completada</option>
          <option value="cancelada">Cancelada</option>
        </select>
        
        <input v-model="filterDate" type="date"
               class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
      </div>
      
      <div class="flex space-x-2">
        <button @click="exportReservas"
                class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 transition-colors flex items-center">
          📊 Exportar
        </button>
        <button @click="refreshData"
                class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors flex items-center">
          🔄 Actualizar
        </button>
      </div>
    </div>

    <!-- Reservations Table -->
    <div class="bg-white rounded-xl shadow-lg overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Cliente
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Servicio
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Fecha & Hora
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Estado
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Precio
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Acciones
              </th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="reserva in filteredReservas" :key="reserva.id" 
                class="hover:bg-gray-50 transition-colors">
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <div class="w-10 h-10 bg-gradient-to-r from-pink-500 to-orange-500 rounded-full flex items-center justify-center mr-3">
                    <span class="text-white font-bold text-sm">{{ getInitials(reserva.cliente) }}</span>
                  </div>
                  <div>
                    <div class="text-sm font-medium text-gray-900">{{ reserva.cliente }}</div>
                    <div class="text-sm text-gray-500">{{ reserva.telefono }}</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <span class="text-2xl mr-2">{{ getServiceIcon(reserva.servicio) }}</span>
                  <div>
                    <div class="text-sm font-medium text-gray-900">{{ reserva.servicio }}</div>
                    <div class="text-sm text-gray-500">{{ reserva.duracion }} min</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">{{ formatDate(reserva.fecha) }}</div>
                <div class="text-sm text-gray-500">{{ reserva.hora }}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="getStatusClass(reserva.estado)" 
                      class="inline-flex px-2 py-1 text-xs font-semibold rounded-full">
                  {{ getStatusText(reserva.estado) }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                ${{ reserva.precio.toLocaleString() }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                <button @click="editReserva(reserva)" 
                        class="text-blue-600 hover:text-blue-900 transition-colors">
                  ✏️
                </button>
                <button @click="updateStatus(reserva)" 
                        class="text-green-600 hover:text-green-900 transition-colors">
                  ✅
                </button>
                <button @click="cancelReserva(reserva)" 
                        class="text-red-600 hover:text-red-900 transition-colors">
                  ❌
                </button>
                <button @click="viewDetails(reserva)" 
                        class="text-purple-600 hover:text-purple-900 transition-colors">
                  👁️
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Pagination -->
    <div class="flex items-center justify-between">
      <div class="text-sm text-gray-700">
        Mostrando {{ (currentPage - 1) * itemsPerPage + 1 }} a {{ Math.min(currentPage * itemsPerPage, totalReservas) }} de {{ totalReservas }} reservas
      </div>
      <div class="flex space-x-2">
        <button @click="previousPage" :disabled="currentPage === 1"
                class="px-3 py-2 bg-gray-200 text-gray-700 rounded-lg disabled:opacity-50 hover:bg-gray-300 transition-colors">
          Anterior
        </button>
        <span class="px-3 py-2 bg-pink-500 text-white rounded-lg">
          {{ currentPage }}
        </span>
        <button @click="nextPage" :disabled="currentPage >= totalPages"
                class="px-3 py-2 bg-gray-200 text-gray-700 rounded-lg disabled:opacity-50 hover:bg-gray-300 transition-colors">
          Siguiente
        </button>
      </div>
    </div>

    <!-- Edit Modal -->
    <div v-if="showEditModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-2xl max-w-lg w-full p-6 max-h-[90vh] overflow-y-auto">
        <h3 class="text-xl font-bold text-gray-900 mb-4">Editar Reserva</h3>
        <form @submit.prevent="saveEdit" class="space-y-4">
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Cliente</label>
              <input v-model="editingReserva.cliente" type="text" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Teléfono</label>
              <input v-model="editingReserva.telefono" type="tel" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Servicio</label>
            <select v-model="editingReserva.servicio" required
                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
              <option value="Manicure">Manicure</option>
              <option value="Pedicure">Pedicure</option>
              <option value="Facial">Facial</option>
              <option value="Masaje">Masaje</option>
              <option value="Depilación">Depilación</option>
              <option value="Maquillaje">Maquillaje</option>
            </select>
          </div>
          
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Fecha</label>
              <input v-model="editingReserva.fecha" type="date" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Hora</label>
              <input v-model="editingReserva.hora" type="time" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
          </div>
          
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Estado</label>
              <select v-model="editingReserva.estado" required
                      class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
                <option value="pendiente">Pendiente</option>
                <option value="confirmada">Confirmada</option>
                <option value="en-proceso">En Proceso</option>
                <option value="completada">Completada</option>
                <option value="cancelada">Cancelada</option>
              </select>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Precio</label>
              <input v-model="editingReserva.precio" type="number" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Notas</label>
            <textarea v-model="editingReserva.notas" rows="3"
                      class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500"></textarea>
          </div>
          
          <div class="flex space-x-3 pt-4">
            <button type="submit"
                    class="flex-1 bg-gradient-to-r from-pink-500 to-orange-500 text-white py-2 px-4 rounded-lg hover:shadow-lg transition-all duration-300">
              Guardar Cambios
            </button>
            <button type="button" @click="showEditModal = false"
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
const searchTerm = ref('')
const filterStatus = ref('')
const filterDate = ref('')
const currentPage = ref(1)
const itemsPerPage = 10
const showEditModal = ref(false)
const editingReserva = ref({})

// Sample data - in a real app, this would come from an API
const reservas = ref([
  {
    id: 1,
    cliente: 'María García',
    telefono: '+57 300 123 4567',
    servicio: 'Manicure',
    fecha: '2024-01-20',
    hora: '10:00',
    estado: 'pendiente',
    precio: 50000,
    duracion: 60,
    notas: 'Cliente preferencial'
  },
  {
    id: 2,
    cliente: 'Ana López',
    telefono: '+57 301 234 5678',
    servicio: 'Facial',
    fecha: '2024-01-20',
    hora: '14:00',
    estado: 'confirmada',
    precio: 80000,
    duracion: 90,
    notas: 'Primera visita'
  },
  {
    id: 3,
    cliente: 'Carmen Ruiz',
    telefono: '+57 302 345 6789',
    servicio: 'Pedicure',
    fecha: '2024-01-21',
    hora: '11:30',
    estado: 'en-proceso',
    precio: 60000,
    duracion: 75,
    notas: ''
  },
  {
    id: 4,
    cliente: 'Sofía Martín',
    telefono: '+57 303 456 7890',
    servicio: 'Masaje',
    fecha: '2024-01-21',
    hora: '16:00',
    estado: 'completada',
    precio: 120000,
    duracion: 120,
    notas: 'Masaje relajante'
  },
  {
    id: 5,
    cliente: 'Isabella Torres',
    telefono: '+57 304 567 8901',
    servicio: 'Maquillaje',
    fecha: '2024-01-22',
    hora: '09:00',
    estado: 'confirmada',
    precio: 100000,
    duracion: 90,
    notas: 'Evento especial'
  }
])

const filteredReservas = computed(() => {
  let filtered = reservas.value
  
  if (searchTerm.value) {
    filtered = filtered.filter(r => 
      r.cliente.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      r.servicio.toLowerCase().includes(searchTerm.value.toLowerCase())
    )
  }
  
  if (filterStatus.value) {
    filtered = filtered.filter(r => r.estado === filterStatus.value)
  }
  
  if (filterDate.value) {
    filtered = filtered.filter(r => r.fecha === filterDate.value)
  }
  
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  
  return filtered.slice(start, end)
})

const totalReservas = computed(() => {
  let filtered = reservas.value
  
  if (searchTerm.value) {
    filtered = filtered.filter(r => 
      r.cliente.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      r.servicio.toLowerCase().includes(searchTerm.value.toLowerCase())
    )
  }
  
  if (filterStatus.value) {
    filtered = filtered.filter(r => r.estado === filterStatus.value)
  }
  
  if (filterDate.value) {
    filtered = filtered.filter(r => r.fecha === filterDate.value)
  }
  
  return filtered.length
})

const totalPages = computed(() => Math.ceil(totalReservas.value / itemsPerPage))

const getInitials = (name) => {
  return name.split(' ').map(n => n[0]).join('').toUpperCase()
}

const getServiceIcon = (service) => {
  const icons = {
    'Manicure': '💅',
    'Pedicure': '🦶',
    'Facial': '✨',
    'Masaje': '💆‍♀️',
    'Depilación': '🪒',
    'Maquillaje': '💄'
  }
  return icons[service] || '💆‍♀️'
}

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('es-ES', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  })
}

const getStatusClass = (status) => {
  const classes = {
    'pendiente': 'bg-yellow-100 text-yellow-800',
    'confirmada': 'bg-blue-100 text-blue-800',
    'en-proceso': 'bg-purple-100 text-purple-800',
    'completada': 'bg-green-100 text-green-800',
    'cancelada': 'bg-red-100 text-red-800'
  }
  return classes[status] || 'bg-gray-100 text-gray-800'
}

const getStatusText = (status) => {
  const texts = {
    'pendiente': 'Pendiente',
    'confirmada': 'Confirmada',
    'en-proceso': 'En Proceso',
    'completada': 'Completada',
    'cancelada': 'Cancelada'
  }
  return texts[status] || 'Desconocido'
}

const editReserva = (reserva) => {
  editingReserva.value = { ...reserva }
  showEditModal.value = true
}

const saveEdit = () => {
  const index = reservas.value.findIndex(r => r.id === editingReserva.value.id)
  if (index !== -1) {
    reservas.value[index] = { ...editingReserva.value }
  }
  showEditModal.value = false
}

const updateStatus = (reserva) => {
  const statusOrder = ['pendiente', 'confirmada', 'en-proceso', 'completada']
  const currentIndex = statusOrder.indexOf(reserva.estado)
  const nextIndex = (currentIndex + 1) % statusOrder.length
  reserva.estado = statusOrder[nextIndex]
}

const cancelReserva = (reserva) => {
  if (confirm(`¿Estás seguro de cancelar la reserva de ${reserva.cliente}?`)) {
    reserva.estado = 'cancelada'
  }
}

const viewDetails = (reserva) => {
  alert(`Detalles de la reserva:\n\nCliente: ${reserva.cliente}\nServicio: ${reserva.servicio}\nFecha: ${formatDate(reserva.fecha)}\nHora: ${reserva.hora}\nPrecio: $${reserva.precio.toLocaleString()}\nNotas: ${reserva.notas || 'Sin notas'}`)
}

const previousPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
  }
}

const exportReservas = () => {
  // Export functionality would be implemented here
  alert('Exportando reservas...')
}

const refreshData = () => {
  // Refresh functionality would be implemented here
  alert('Datos actualizados')
}
</script>