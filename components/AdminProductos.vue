<template>
  <div class="space-y-6">
    <!-- Filters and Search -->
    <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between space-y-4 lg:space-y-0">
      <div class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-4">
        <div class="relative">
          <input v-model="searchTerm" type="text" placeholder="Buscar por cliente o producto..."
                 class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500 w-full sm:w-64">
          <span class="absolute left-3 top-2.5 text-gray-400">🔍</span>
        </div>
        
        <select v-model="filterStatus" 
                class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
          <option value="">Todos los estados</option>
          <option value="pendiente">Pendiente</option>
          <option value="procesando">Procesando</option>
          <option value="enviado">Enviado</option>
          <option value="entregado">Entregado</option>
          <option value="cancelado">Cancelado</option>
        </select>
        
        <select v-model="filterCategory" 
                class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
          <option value="">Todas las categorías</option>
          <option value="Cuidado Facial">Cuidado Facial</option>
          <option value="Maquillaje">Maquillaje</option>
          <option value="Cuidado Corporal">Cuidado Corporal</option>
          <option value="Uñas">Uñas</option>
          <option value="Cabello">Cabello</option>
        </select>
      </div>
      
      <div class="flex space-x-2">
        <button @click="exportSolicitudes"
                class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 transition-colors flex items-center">
          📊 Exportar
        </button>
        <button @click="refreshData"
                class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors flex items-center">
          🔄 Actualizar
        </button>
      </div>
    </div>

    <!-- Status Summary Cards -->
    <div class="grid grid-cols-2 md:grid-cols-5 gap-4">
      <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4 text-center">
        <div class="text-2xl font-bold text-yellow-600">{{ getStatusCount('pendiente') }}</div>
        <div class="text-sm text-yellow-600 font-medium">Pendientes</div>
      </div>
      <div class="bg-blue-50 border border-blue-200 rounded-lg p-4 text-center">
        <div class="text-2xl font-bold text-blue-600">{{ getStatusCount('procesando') }}</div>
        <div class="text-sm text-blue-600 font-medium">Procesando</div>
      </div>
      <div class="bg-purple-50 border border-purple-200 rounded-lg p-4 text-center">
        <div class="text-2xl font-bold text-purple-600">{{ getStatusCount('enviado') }}</div>
        <div class="text-sm text-purple-600 font-medium">Enviados</div>
      </div>
      <div class="bg-green-50 border border-green-200 rounded-lg p-4 text-center">
        <div class="text-2xl font-bold text-green-600">{{ getStatusCount('entregado') }}</div>
        <div class="text-sm text-green-600 font-medium">Entregados</div>
      </div>
      <div class="bg-red-50 border border-red-200 rounded-lg p-4 text-center">
        <div class="text-2xl font-bold text-red-600">{{ getStatusCount('cancelado') }}</div>
        <div class="text-sm text-red-600 font-medium">Cancelados</div>
      </div>
    </div>

    <!-- Product Requests Table -->
    <div class="bg-white rounded-xl shadow-lg overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Cliente
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Producto
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Cantidad
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Estado
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Total
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Fecha
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Acciones
              </th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="solicitud in filteredSolicitudes" :key="solicitud.id" 
                class="hover:bg-gray-50 transition-colors">
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <div class="w-10 h-10 bg-gradient-to-r from-purple-500 to-pink-500 rounded-full flex items-center justify-center mr-3">
                    <span class="text-white font-bold text-sm">{{ getInitials(solicitud.cliente) }}</span>
                  </div>
                  <div>
                    <div class="text-sm font-medium text-gray-900">{{ solicitud.cliente }}</div>
                    <div class="text-sm text-gray-500">{{ solicitud.email }}</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4">
                <div class="flex items-center">
                  <img :src="solicitud.imagen" :alt="solicitud.producto" 
                       class="w-12 h-12 rounded-lg object-cover mr-3">
                  <div>
                    <div class="text-sm font-medium text-gray-900">{{ solicitud.producto }}</div>
                    <div class="text-sm text-gray-500">{{ solicitud.categoria }}</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span class="text-sm text-gray-900 font-medium">{{ solicitud.cantidad }}</span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="getStatusClass(solicitud.estado)" 
                      class="inline-flex px-2 py-1 text-xs font-semibold rounded-full">
                  {{ getStatusText(solicitud.estado) }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                ${{ (solicitud.precio * solicitud.cantidad).toLocaleString() }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {{ formatDate(solicitud.fecha) }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                <button @click="editSolicitud(solicitud)" 
                        class="text-blue-600 hover:text-blue-900 transition-colors">
                  ✏️
                </button>
                <button @click="updateStatus(solicitud)" 
                        class="text-green-600 hover:text-green-900 transition-colors">
                  📦
                </button>
                <button @click="sendMessage(solicitud)" 
                        class="text-purple-600 hover:text-purple-900 transition-colors">
                  💬
                </button>
                <button @click="viewDetails(solicitud)" 
                        class="text-orange-600 hover:text-orange-900 transition-colors">
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
        Mostrando {{ (currentPage - 1) * itemsPerPage + 1 }} a {{ Math.min(currentPage * itemsPerPage, totalSolicitudes) }} de {{ totalSolicitudes }} solicitudes
      </div>
      <div class="flex space-x-2">
        <button @click="previousPage" :disabled="currentPage === 1"
                class="px-3 py-2 bg-gray-200 text-gray-700 rounded-lg disabled:opacity-50 hover:bg-gray-300 transition-colors">
          Anterior
        </button>
        <span class="px-3 py-2 bg-purple-500 text-white rounded-lg">
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
        <h3 class="text-xl font-bold text-gray-900 mb-4">Editar Solicitud</h3>
        <form @submit.prevent="saveEdit" class="space-y-4">
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Cliente</label>
              <input v-model="editingSolicitud.cliente" type="text" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
              <input v-model="editingSolicitud.email" type="email" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Producto</label>
            <input v-model="editingSolicitud.producto" type="text" required
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
          </div>
          
          <div class="grid grid-cols-3 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Cantidad</label>
              <input v-model="editingSolicitud.cantidad" type="number" min="1" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Precio</label>
              <input v-model="editingSolicitud.precio" type="number" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Estado</label>
              <select v-model="editingSolicitud.estado" required
                      class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
                <option value="pendiente">Pendiente</option>
                <option value="procesando">Procesando</option>
                <option value="enviado">Enviado</option>
                <option value="entregado">Entregado</option>
                <option value="cancelado">Cancelado</option>
              </select>
            </div>
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Categoría</label>
            <select v-model="editingSolicitud.categoria" required
                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
              <option value="Cuidado Facial">Cuidado Facial</option>
              <option value="Maquillaje">Maquillaje</option>
              <option value="Cuidado Corporal">Cuidado Corporal</option>
              <option value="Uñas">Uñas</option>
              <option value="Cabello">Cabello</option>
            </select>
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Notas</label>
            <textarea v-model="editingSolicitud.notas" rows="3"
                      class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500"></textarea>
          </div>
          
          <div class="flex space-x-3 pt-4">
            <button type="submit"
                    class="flex-1 bg-gradient-to-r from-purple-500 to-pink-500 text-white py-2 px-4 rounded-lg hover:shadow-lg transition-all duration-300">
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

    <!-- Message Modal -->
    <div v-if="showMessageModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-2xl max-w-md w-full p-6">
        <h3 class="text-xl font-bold text-gray-900 mb-4">Enviar Mensaje</h3>
        <form @submit.prevent="sendMessageToClient" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Para: {{ messageTarget?.cliente }}</label>
            <input :value="messageTarget?.email" type="email" readonly
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-50">
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Asunto</label>
            <input v-model="messageData.subject" type="text" required
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500">
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Mensaje</label>
            <textarea v-model="messageData.message" rows="4" required
                      class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500"></textarea>
          </div>
          
          <div class="flex space-x-3 pt-4">
            <button type="submit"
                    class="flex-1 bg-gradient-to-r from-blue-500 to-purple-500 text-white py-2 px-4 rounded-lg hover:shadow-lg transition-all duration-300">
              Enviar Mensaje
            </button>
            <button type="button" @click="showMessageModal = false"
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
const filterCategory = ref('')
const currentPage = ref(1)
const itemsPerPage = 10
const showEditModal = ref(false)
const showMessageModal = ref(false)
const editingSolicitud = ref({})
const messageTarget = ref(null)
const messageData = ref({
  subject: '',
  message: ''
})

// Sample data - in a real app, this would come from an API
const solicitudes = ref([
  {
    id: 1,
    cliente: 'María García',
    email: 'maria@email.com',
    producto: 'Crema Hidratante Premium',
    categoria: 'Cuidado Facial',
    cantidad: 2,
    precio: 85000,
    estado: 'pendiente',
    fecha: '2024-01-20',
    imagen: 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=100&h=100&fit=crop',
    notas: 'Cliente preferencial'
  },
  {
    id: 2,
    cliente: 'Ana López',
    email: 'ana@email.com',
    producto: 'Set de Maquillaje Profesional',
    categoria: 'Maquillaje',
    cantidad: 1,
    precio: 150000,
    estado: 'procesando',
    fecha: '2024-01-19',
    imagen: 'https://images.unsplash.com/photo-1583241800698-4828ce446e97?w=100&h=100&fit=crop',
    notas: 'Urgente para evento'
  },
  {
    id: 3,
    cliente: 'Carmen Ruiz',
    email: 'carmen@email.com',
    producto: 'Esmalte de Uñas Colección',
    categoria: 'Uñas',
    cantidad: 5,
    precio: 25000,
    estado: 'enviado',
    fecha: '2024-01-18',
    imagen: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=100&h=100&fit=crop',
    notas: ''
  },
  {
    id: 4,
    cliente: 'Sofía Martín',
    email: 'sofia@email.com',
    producto: 'Aceite Corporal Relajante',
    categoria: 'Cuidado Corporal',
    cantidad: 3,
    precio: 60000,
    estado: 'entregado',
    fecha: '2024-01-17',
    imagen: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100&h=100&fit=crop',
    notas: 'Entregado con éxito'
  },
  {
    id: 5,
    cliente: 'Isabella Torres',
    email: 'isabella@email.com',
    producto: 'Champú Reparador',
    categoria: 'Cabello',
    cantidad: 2,
    precio: 45000,
    estado: 'cancelado',
    fecha: '2024-01-16',
    imagen: 'https://images.unsplash.com/photo-1556228578-7ba8b08b1c70?w=100&h=100&fit=crop',
    notas: 'Cancelado por cliente'
  }
])

const filteredSolicitudes = computed(() => {
  let filtered = solicitudes.value
  
  if (searchTerm.value) {
    filtered = filtered.filter(s => 
      s.cliente.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      s.producto.toLowerCase().includes(searchTerm.value.toLowerCase())
    )
  }
  
  if (filterStatus.value) {
    filtered = filtered.filter(s => s.estado === filterStatus.value)
  }
  
  if (filterCategory.value) {
    filtered = filtered.filter(s => s.categoria === filterCategory.value)
  }
  
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  
  return filtered.slice(start, end)
})

const totalSolicitudes = computed(() => {
  let filtered = solicitudes.value
  
  if (searchTerm.value) {
    filtered = filtered.filter(s => 
      s.cliente.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      s.producto.toLowerCase().includes(searchTerm.value.toLowerCase())
    )
  }
  
  if (filterStatus.value) {
    filtered = filtered.filter(s => s.estado === filterStatus.value)
  }
  
  if (filterCategory.value) {
    filtered = filtered.filter(s => s.categoria === filterCategory.value)
  }
  
  return filtered.length
})

const totalPages = computed(() => Math.ceil(totalSolicitudes.value / itemsPerPage))

const getStatusCount = (status) => {
  return solicitudes.value.filter(s => s.estado === status).length
}

const getInitials = (name) => {
  return name.split(' ').map(n => n[0]).join('').toUpperCase()
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
    'procesando': 'bg-blue-100 text-blue-800',
    'enviado': 'bg-purple-100 text-purple-800',
    'entregado': 'bg-green-100 text-green-800',
    'cancelado': 'bg-red-100 text-red-800'
  }
  return classes[status] || 'bg-gray-100 text-gray-800'
}

const getStatusText = (status) => {
  const texts = {
    'pendiente': 'Pendiente',
    'procesando': 'Procesando',
    'enviado': 'Enviado',
    'entregado': 'Entregado',
    'cancelado': 'Cancelado'
  }
  return texts[status] || 'Desconocido'
}

const editSolicitud = (solicitud) => {
  editingSolicitud.value = { ...solicitud }
  showEditModal.value = true
}

const saveEdit = () => {
  const index = solicitudes.value.findIndex(s => s.id === editingSolicitud.value.id)
  if (index !== -1) {
    solicitudes.value[index] = { ...editingSolicitud.value }
  }
  showEditModal.value = false
}

const updateStatus = (solicitud) => {
  const statusOrder = ['pendiente', 'procesando', 'enviado', 'entregado']
  const currentIndex = statusOrder.indexOf(solicitud.estado)
  const nextIndex = (currentIndex + 1) % statusOrder.length
  solicitud.estado = statusOrder[nextIndex]
}

const sendMessage = (solicitud) => {
  messageTarget.value = solicitud
  messageData.value = {
    subject: `Actualización de tu pedido: ${solicitud.producto}`,
    message: `Hola ${solicitud.cliente},\n\nQueríamos informarte sobre el estado de tu pedido...\n\nSaludos,\nEquipo Toda Bonita`
  }
  showMessageModal.value = true
}

const sendMessageToClient = () => {
  // Here you would implement the actual message sending
  alert(`Mensaje enviado a ${messageTarget.value.cliente}`)
  showMessageModal.value = false
  messageData.value = { subject: '', message: '' }
  messageTarget.value = null
}

const viewDetails = (solicitud) => {
  alert(`Detalles de la solicitud:\n\nCliente: ${solicitud.cliente}\nProducto: ${solicitud.producto}\nCantidad: ${solicitud.cantidad}\nTotal: $${(solicitud.precio * solicitud.cantidad).toLocaleString()}\nEstado: ${getStatusText(solicitud.estado)}\nFecha: ${formatDate(solicitud.fecha)}\nNotas: ${solicitud.notas || 'Sin notas'}`)
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

const exportSolicitudes = () => {
  // Export functionality would be implemented here
  alert('Exportando solicitudes...')
}

const refreshData = () => {
  // Refresh functionality would be implemented here
  alert('Datos actualizados')
}
</script>