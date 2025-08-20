<template>
  <footer class="bg-gradient-to-r from-pink-400 to-orange-300 text-white py-12 px-6">
    <div class="max-w-6xl mx-auto">
      <div class="grid md:grid-cols-4 gap-8 mb-8">
        <div>
          <div class="flex items-center space-x-3 mb-4">
            <div class="w-8 h-8 rounded-lg bg-white/20 flex items-center justify-center">
              <div class="w-4 h-4 rounded-full bg-white"></div>
            </div>
            <h3 class="text-2xl font-bold">Toda Bonita</h3>
          </div>
          <p class="text-white/90">
            Tu salón de belleza de confianza donde cada visita es una experiencia única.
          </p>
        </div>
        
        <div>
          <h4 class="font-bold mb-4">Servicios Populares</h4>
          <ul class="space-y-2 text-white/90">
            <li>• Cambios de look</li>
            <li>• Manicura gel</li>
            <li>• Extensiones</li>
            <li>• Tratamientos faciales</li>
          </ul>
        </div>
        
        <div>
          <h4 class="font-bold mb-4">Enlaces Rápidos</h4>
          <ul class="space-y-2 text-white/90">
            <li class="cursor-pointer hover:text-white transition-colors">Sobre Nosotros</li>
            <li class="cursor-pointer hover:text-white transition-colors">Promociones</li>
            <li class="cursor-pointer hover:text-white transition-colors">Blog de Belleza</li>
            <li class="cursor-pointer hover:text-white transition-colors">Trabaja con Nosotros</li>
          </ul>
        </div>
        
        <div>
          <h4 class="font-bold mb-4">Newsletter</h4>
          <p class="text-white/90 mb-4">
            Recibe tips de belleza y ofertas exclusivas
          </p>
          <div class="flex">
            <input 
              v-model="email"
              type="email" 
              placeholder="Tu email"
              class="px-4 py-2 rounded-l-full bg-white/20 placeholder-white/70 flex-1 outline-none focus:bg-white/30 text-white"
            />
            <button 
              @click="subscribeNewsletter"
              class="px-6 py-2 bg-white text-pink-500 rounded-r-2xl font-bold hover:bg-white/90 transition-colors flex items-center justify-center"
            >
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
              </svg>
            </button>
          </div>
        </div>
      </div>
      
      <div class="border-t border-white/30 pt-8 text-center">
        <p class="text-white/90">
          © 2024 Toda Bonita. Todos los derechos reservados. 
          <span class="ml-2">Hecho con pasión</span>
        </p>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { ref } from 'vue'

const email = ref('')

const subscribeNewsletter = () => {
  if (email.value) {
    // Aquí puedes agregar la lógica para suscribir al newsletter
    alert(`¡Gracias por suscribirte con ${email.value}!`)
    email.value = ''
  }
}
</script>