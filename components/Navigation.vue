<template>
  <div class="relative">
    <!-- Navegación Móvil Superior -->
    <nav class="lg:hidden fixed top-0 left-0 right-0 z-50 bg-white/95 backdrop-blur-xl shadow-lg border-b border-pink-100/50">
      <div class="flex items-center justify-between p-4">
        <div class="flex items-center space-x-3">
          <div class="relative">
            <div class="w-10 h-10 rounded-2xl bg-gradient-to-br from-pink-400 via-rose-400 to-orange-400 flex items-center justify-center shadow-lg transform rotate-3 hover:rotate-0 transition-transform duration-300">
              <Icon name="lucide:sparkles" class="w-5 h-5 text-white" />
            </div>
            <div class="absolute -top-1 -right-1 w-3 h-3 bg-gradient-to-br from-yellow-300 to-orange-300 rounded-full animate-pulse"></div>
          </div>
          <div>
            <h1 class="text-2xl font-bold gradient-text-enhanced tracking-tight">Toda Bonita</h1>
            <p class="text-xs text-pink-400 opacity-80">Beauty Studio</p>
          </div>
        </div>
        <button
          @click="toggleMobileMenu"
          class="relative p-3 rounded-2xl bg-gradient-to-br from-pink-50 to-orange-50 text-pink-600 hover:from-pink-100 hover:to-orange-100 transition-all duration-300 group shadow-md hover:shadow-lg"
        >
          <Icon 
            :name="mobileMenuOpen ? 'lucide:x' : 'lucide:menu'" 
            class="w-5 h-5 transition-all duration-300 group-hover:scale-110" 
          />
        </button>
      </div>
      <div v-if="mobileMenuOpen" class="animate-fade-in-up bg-white/98 backdrop-blur-xl border-t border-pink-100/50">
        <div class="p-2 space-y-1">
          <NuxtLink
            v-for="(item, index) in navItems"
            :key="item.id"
            :to="item.route"
            :class="[
              'mobile-nav-item block w-full text-left px-4 py-3 rounded-xl transition-all duration-300 group relative overflow-hidden',
              $route.path === item.route ? 'bg-gradient-to-r from-pink-100 to-orange-100 text-pink-700' : 'hover:bg-gradient-to-r hover:from-pink-50 hover:to-orange-50'
            ]"
            :style="{ animationDelay: `${index * 50}ms` }"
            @click="mobileMenuOpen = false"
          >
            <div class="flex items-center space-x-3">
              <Icon :name="item.icon" class="w-5 h-5 text-pink-500 group-hover:scale-110 transition-transform" />
              <span class="font-medium">{{ item.label }}</span>
            </div>
          </NuxtLink>
        </div>
        <div class="p-4 border-t border-pink-100/50">
          <button class="cta-button w-full py-3 px-6 bg-gradient-to-r from-pink-400 to-orange-300 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 relative overflow-hidden group">
            <span class="relative z-10 flex items-center justify-center space-x-2">
              <Icon name="lucide:calendar" class="w-4 h-4" />
              <span>Reservar Cita</span>
            </span>
          </button>
        </div>
      </div>
    </nav>

    <!-- Navegación Lateral Desktop -->
    <nav class="hidden lg:block fixed left-0 top-0 bottom-0 w-72 z-40 backdrop-blur-xl bg-white/95 border-r shadow-xl border-pink-100/50 modern-sidebar">
      <div class="p-6 h-full flex flex-col">
        <!-- Logo Section Enhanced -->
        <div class="mb-8 text-center relative">
          <div class="relative inline-block">
            <div class="w-16 h-16 mx-auto mb-4 rounded-3xl bg-gradient-to-br from-pink-400 via-rose-400 to-orange-400 flex items-center justify-center shadow-2xl transform hover:scale-105 transition-all duration-300 beauty-glow">
              <Icon name="lucide:sparkles" class="w-8 h-8 text-white drop-shadow-sm" />
            </div>
            <div class="absolute -top-2 -right-2 w-5 h-5 bg-gradient-to-br from-yellow-300 to-orange-300 rounded-full animate-pulse sparkle-effect"></div>
            <div class="absolute -bottom-1 -left-1 w-3 h-3 bg-gradient-to-br from-green-300 to-emerald-300 rounded-full animate-pulse" style="animation-delay: 1s"></div>
          </div>
          <h2 class="text-2xl font-bold gradient-text-enhanced tracking-tight mb-1">Toda Bonita</h2>
          <p class="text-sm text-pink-400 opacity-80 font-medium">Beauty Studio Exclusive</p>
          <div class="w-12 h-0.5 bg-gradient-to-r from-pink-300 to-orange-300 mx-auto mt-3 rounded-full"></div>
        </div>

        <!-- Navigation Items -->
        <ul class="space-y-3 flex-1">
          <li v-for="(item, index) in navItems" :key="item.id" class="group">
            <NuxtLink
              :to="item.route"
              :class="[
                'nav-item-enhanced w-full text-left px-5 py-4 rounded-2xl transition-all duration-300 group relative overflow-hidden block',
                $route.path === item.route 
                  ? 'bg-gradient-to-r from-pink-100 via-rose-50 to-orange-100 text-pink-700 shadow-lg transform scale-105' 
                  : 'hover:bg-gradient-to-r hover:from-pink-50 hover:to-orange-50 hover:translate-x-2 hover:shadow-lg'
              ]"
              :style="{ animationDelay: `${index * 100}ms` }"
            >
              <div class="flex items-center space-x-4 relative z-10">
                <div class="relative">
                  <Icon 
                    :name="item.icon" 
                    class="w-5 h-5 text-pink-500 group-hover:text-pink-600 group-hover:scale-110 transition-all duration-300" 
                  />
                  <div v-if="$route.path === item.route" class="absolute -inset-1 bg-pink-200/30 rounded-lg -z-10 animate-pulse"></div>
                </div>
                <span class="font-medium text-gray-700 group-hover:text-gray-800">{{ item.label }}</span>
                <div class="ml-auto opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                  <Icon name="lucide:arrow-right" class="w-4 h-4 text-pink-400" />
                </div>
              </div>
              
              <!-- Hover effect background -->
              <div class="absolute inset-0 bg-gradient-to-r from-pink-200/20 to-orange-200/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-2xl"></div>
            </NuxtLink>
          </li>
        </ul>

        <!-- Bottom Section -->
        <div class="mt-6 space-y-4">
          <button class="cta-button w-full py-4 px-6 bg-gradient-to-r from-pink-400 via-rose-400 to-orange-400 text-white font-semibold rounded-2xl shadow-xl hover:shadow-2xl transition-all duration-300 relative overflow-hidden group transform hover:scale-105">
            <span class="relative z-10 flex items-center justify-center space-x-2">
              <Icon name="lucide:calendar-heart" class="w-5 h-5 group-hover:animate-pulse" />
              <span>Reservar Cita</span>
            </span>
            <div class="absolute inset-0 bg-gradient-to-r from-white/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
          </button>
          
          <!-- Status indicator -->
          <div class="flex items-center justify-center space-x-3 py-3 bg-gradient-to-r from-green-50 to-emerald-50 rounded-2xl border border-green-100">
            <div class="flex items-center space-x-2">
              <div class="w-2 h-2 bg-green-400 rounded-full animate-pulse"></div>
              <span class="text-xs font-medium text-green-600">Abierto</span>
            </div>
            <div class="w-px h-4 bg-green-200"></div>
            <span class="text-xs text-green-500">9:00 AM - 8:00 PM</span>
          </div>
          
          <!-- Decorative footer -->
          <div class="text-center py-2">
            <div class="flex items-center justify-center space-x-2 text-xs text-pink-400 opacity-60">
              <Icon name="lucide:heart" class="w-3 h-3" />
              <span class="font-medium">Hecho con amor</span>
              <Icon name="lucide:heart" class="w-3 h-3" />
            </div>
          </div>
        </div>
      </div>
    </nav>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const mobileMenuOpen = ref(false)

const navItems = [
  { id: 'inicio', label: 'Inicio', icon: 'lucide:home', route: '/' },
  { id: 'servicios', label: 'Servicios', icon: 'lucide:scissors', route: '/servicios' },
  { id: 'productos', label: 'Productos', icon: 'lucide:shopping-bag', route: '/productos' },
  { id: 'galeria', label: 'Galería', icon: 'lucide:image', route: '/galeria' },
  { id: 'reservas', label: 'Reservas', icon: 'lucide:calendar-check', route: '/reservas' },
  { id: 'contacto', label: 'Contacto', icon: 'lucide:phone', route: '/contacto' },
]

const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}
</script>