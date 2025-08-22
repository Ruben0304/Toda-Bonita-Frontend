<template>
  <div class="min-h-screen">
    <!-- Three.js Background -->
    <ThreeBackground />
    
    <!-- Hero Section con animaciones sutiles -->
    <section id="inicio" class="min-h-screen relative overflow-hidden pt-16 lg:pt-0">
      <HeroAnimations>
        <!-- Título principal con animación sutil -->
        <template #text-reveal>
          <h1 
            class="text-4xl sm:text-5xl md:text-6xl lg:text-8xl font-bold mb-4 tracking-tight font-playfair"
            data-aos="fade-up"
            data-aos-duration="800"
          >
            Toda Bonita
          </h1>
        </template>
        
        <!-- Subtítulo -->
        <template #subtitle>
          La etapa de ser nuestra clienta... ¡Te recomiendo no saltártela!
        </template>
        
        <!-- Botones -->
        <template #buttons>
          <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
            <NuxtLink to="/reserva">
              <button class="group w-full sm:w-auto px-6 md:px-8 py-3 md:py-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-bold rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300 text-base md:text-lg relative overflow-hidden">
                <span class="relative z-10 flex items-center justify-center space-x-2">
                  <Icon name="lucide:calendar-heart" class="w-4 md:w-5 h-4 md:h-5" />
                  <span class="hidden sm:inline">Reservar Mi Transformación</span>
                  <span class="sm:hidden">Reservar Cita</span>
                  <Icon name="lucide:arrow-right" class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                </span>
              </button>
            </NuxtLink>
            
            <button 
              @click="scrollToSection('servicios')"
              class="group w-full sm:w-auto px-6 md:px-8 py-3 md:py-4 bg-white/90 backdrop-blur-sm border border-pink-300 text-pink-600 font-bold rounded-full shadow-md hover:shadow-lg transform hover:scale-105 transition-all duration-300 text-base md:text-lg hover:bg-pink-50 relative overflow-hidden"
            >
              <span class="relative z-10 flex items-center justify-center space-x-2">
                <Icon name="lucide:sparkles" class="w-4 h-4" />
                <span>Descubrir Servicios</span>
                <Icon name="lucide:chevron-down" class="w-4 h-4 group-hover:translate-y-1 transition-transform" />
              </span>
            </button>
          </div>
        </template>
      </HeroAnimations>
      


      <!-- Overlay sutil para legibilidad -->
      <div class="absolute inset-0 bg-white/10 backdrop-blur-[1px]"></div>
    </section>

    <!-- Transformaciones Section -->
    <section id="transformaciones" class="py-16 md:py-24 px-4 md:px-6 relative bg-gradient-to-br from-white to-pink-50/30">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
          <h2 
            class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold mb-6"
            data-aos="fade-up"
            data-aos-duration="1000"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Transformaciones Mágicas
            </span>
          </h2>
          <p 
            class="text-lg md:text-xl text-gray-600 max-w-2xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="1000"
          >
            Mira los increíbles cambios de nuestras clientas
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8">
          <div 
            v-for="(trans, index) in transformaciones"
            :key="index"
            class="group bg-white rounded-3xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2"
            data-aos="zoom-in"
            :data-aos-delay="index * 200"
            data-aos-duration="800"
          >
            <div class="relative">
              <div class="flex h-64">
                <div class="w-1/2 relative overflow-hidden">
                  <div class="absolute top-3 left-3 bg-gray-800 text-white px-3 py-1 rounded-full text-sm font-semibold z-10">
                    Antes
                  </div>
                  <img 
                    :src="trans.antes" 
                    alt="Antes"
                    class="w-full h-full object-cover filter grayscale group-hover:grayscale-0 transition-all duration-500"
                  />
                </div>
                <div class="w-1/2 relative overflow-hidden">
                  <div class="absolute top-3 right-3 bg-green-500 text-white px-3 py-1 rounded-full text-sm font-semibold z-10">
                    Después
                  </div>
                  <img 
                    :src="trans.despues" 
                    alt="Después"
                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                  />
                </div>
              </div>
              <div class="absolute inset-x-0 top-1/2 transform -translate-y-1/2 flex justify-center">
                <div class="bg-white rounded-full p-3 shadow-xl border-4 border-pink-100">
                  <Icon name="lucide:arrow-right" class="w-6 h-6 text-pink-500" />
                </div>
              </div>
            </div>
            <div class="p-6">
              <h3 class="text-xl font-bold text-gray-800 mb-2">{{ trans.titulo }}</h3>
              <p class="text-gray-600">{{ trans.descripcion }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Servicios Section -->
    <section id="servicios" class="py-20 md:py-32 px-4 md:px-6 bg-gradient-to-br from-gray-50/50 to-white relative overflow-hidden">
      <!-- Animated background shapes -->
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute top-20 left-10 w-32 h-32 bg-pink-200/30 rounded-full blur-xl animate-bounce" style="animation-duration: 6s; animation-delay: 0s;"></div>
        <div class="absolute bottom-32 right-20 w-24 h-24 bg-orange-200/40 rounded-full blur-lg animate-bounce" style="animation-duration: 8s; animation-delay: 2s;"></div>
        <div class="absolute top-1/2 right-1/4 w-16 h-16 bg-pink-300/20 rounded-full blur-md animate-bounce" style="animation-duration: 10s; animation-delay: 4s;"></div>
      </div>

      <div class="max-w-7xl mx-auto relative z-10">
        <!-- Header with flowing animation -->
        <div class="text-center mb-20">
          <p 
            class="text-pink-500 font-medium tracking-widest uppercase text-sm mb-4 opacity-80"
            data-aos="fade-up"
            data-aos-duration="800"
          >
            Descubre
          </p>
          <h2 
            class="text-5xl md:text-7xl font-light text-gray-900 mb-6 relative"
            data-aos="fade-up"
            data-aos-delay="100"
            data-aos-duration="1000"
          >
            Nuestros 
            <span class="relative inline-block">
              <span class="bg-gradient-to-r from-pink-500 via-orange-500 to-pink-500 bg-clip-text text-transparent font-semibold">
                Servicios
              </span>
              <div class="absolute -bottom-2 left-0 w-full h-1 bg-gradient-to-r from-pink-400 to-orange-400 rounded-full transform scale-x-0 animate-[scaleX_2s_ease-in-out_infinite] origin-left"></div>
            </span>
          </h2>
          <p 
            class="text-gray-600 text-lg max-w-2xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="1000"
          >
            Experiencias únicas que transforman tu belleza natural
          </p>
        </div>

        <!-- Staggered Services Grid with Real Photos -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <!-- Peluquería -->
          <div 
            class="group relative"
            data-aos="fade-up"
            data-aos-delay="0"
            data-aos-duration="800"
          >
            <div class="relative h-80 rounded-3xl overflow-hidden cursor-pointer">
              <img 
                src="/img/servicio_peluqueria.jpg" 
                alt="Peluquería"
                class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
              />
              <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent opacity-80 group-hover:opacity-60 transition-opacity duration-500"></div>
              <div class="absolute bottom-6 left-6 right-6 text-white">
                <h3 class="text-xl font-semibold mb-2 transform translate-y-4 group-hover:translate-y-0 transition-transform duration-500">
                  Peluquería
                </h3>
                <div class="space-y-1 opacity-0 group-hover:opacity-100 transform translate-y-4 group-hover:translate-y-0 transition-all duration-700 delay-100">
                  <p class="text-sm text-gray-200">• Botox capilar</p>
                  <p class="text-sm text-gray-200">• Keratina y mechas</p>
                  <p class="text-sm text-pink-300 font-medium">+3 servicios más</p>
                </div>
              </div>
              <div class="absolute top-4 right-4 w-8 h-8 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-all duration-500 delay-200">
                <div class="w-3 h-3 bg-pink-400 rounded-full animate-pulse"></div>
              </div>
            </div>
          </div>

          <!-- Extensiones de Pestañas -->
          <div 
            class="group relative"
            data-aos="fade-up"
            data-aos-delay="100"
            data-aos-duration="800"
          >
            <div class="relative h-80 rounded-3xl overflow-hidden cursor-pointer transform md:translate-y-8">
              <img 
                src="/img/servicio_peluqueria2.jpg" 
                alt="Extensiones de Pestañas"
                class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
              />
              <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent opacity-80 group-hover:opacity-60 transition-opacity duration-500"></div>
              <div class="absolute bottom-6 left-6 right-6 text-white">
                <h3 class="text-xl font-semibold mb-2 transform translate-y-4 group-hover:translate-y-0 transition-transform duration-500">
                  Extensiones de Pestañas
                </h3>
                <div class="space-y-1 opacity-0 group-hover:opacity-100 transform translate-y-4 group-hover:translate-y-0 transition-all duration-700 delay-100">
                  <p class="text-sm text-gray-200">• Clásicas y volumen</p>
                  <p class="text-sm text-gray-200">• Lifting de pestañas</p>
                  <p class="text-sm text-pink-300 font-medium">+2 servicios más</p>
                </div>
              </div>
              <div class="absolute top-4 right-4 w-8 h-8 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-all duration-500 delay-200">
                <div class="w-3 h-3 bg-orange-400 rounded-full animate-pulse"></div>
              </div>
            </div>
          </div>

          <!-- Manicura -->
          <div 
            class="group relative"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="800"
          >
            <div class="relative h-80 rounded-3xl overflow-hidden cursor-pointer">
              <img 
                src="/img/servicio_unas.jpg" 
                alt="Manicura"
                class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
              />
              <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent opacity-80 group-hover:opacity-60 transition-opacity duration-500"></div>
              <div class="absolute bottom-6 left-6 right-6 text-white">
                <h3 class="text-xl font-semibold mb-2 transform translate-y-4 group-hover:translate-y-0 transition-transform duration-500">
                  Manicura
                </h3>
                <div class="space-y-1 opacity-0 group-hover:opacity-100 transform translate-y-4 group-hover:translate-y-0 transition-all duration-700 delay-100">
                  <p class="text-sm text-gray-200">• Gel y semipermanente</p>
                  <p class="text-sm text-gray-200">• Diseños únicos</p>
                  <p class="text-sm text-pink-300 font-medium">+2 servicios más</p>
                </div>
              </div>
              <div class="absolute top-4 right-4 w-8 h-8 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-all duration-500 delay-200">
                <div class="w-3 h-3 bg-pink-400 rounded-full animate-pulse"></div>
              </div>
            </div>
          </div>

          <!-- Tratamientos Especiales -->
          <div 
            class="group relative"
            data-aos="fade-up"
            data-aos-delay="300"
            data-aos-duration="800"
          >
            <div class="relative h-80 rounded-3xl overflow-hidden cursor-pointer transform md:translate-y-8">
              <img 
                src="/img/servicio_peluqueria3.jpg" 
                alt="Tratamientos Especiales"
                class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
              />
              <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent opacity-80 group-hover:opacity-60 transition-opacity duration-500"></div>
              <div class="absolute bottom-6 left-6 right-6 text-white">
                <h3 class="text-xl font-semibold mb-2 transform translate-y-4 group-hover:translate-y-0 transition-transform duration-500">
                  Tratamientos Especiales
                </h3>
                <div class="space-y-1 opacity-0 group-hover:opacity-100 transform translate-y-4 group-hover:translate-y-0 transition-all duration-700 delay-100">
                  <p class="text-sm text-gray-200">• Faciales anti-edad</p>
                  <p class="text-sm text-gray-200">• Masajes relajantes</p>
                  <p class="text-sm text-pink-300 font-medium">+6 servicios más</p>
                </div>
              </div>
              <div class="absolute top-4 right-4 w-8 h-8 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-all duration-500 delay-200">
                <div class="w-3 h-3 bg-orange-400 rounded-full animate-pulse"></div>
              </div>
            </div>
          </div>
        </div>

        <!-- Floating CTA -->
        <div class="text-center mt-20">
          <div 
            class="relative inline-block"
            data-aos="fade-up"
            data-aos-delay="400"
            data-aos-duration="800"
          >
            <NuxtLink to="/servicios">
              <button class="group relative px-10 py-4 bg-white border-2 border-pink-300 text-pink-600 rounded-full font-medium overflow-hidden transition-all duration-500 hover:border-pink-400 hover:shadow-xl hover:shadow-pink-100/50 hover:-translate-y-1">
                <span class="relative z-10 flex items-center space-x-3">
                  <span>Explorar todos los servicios</span>
                  <Icon name="lucide:sparkles" class="w-5 h-5 group-hover:rotate-180 transition-transform duration-500" />
                </span>
                <div class="absolute inset-0 bg-gradient-to-r from-pink-500 to-orange-500 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left"></div>
                <span class="absolute inset-0 flex items-center justify-center text-white opacity-0 group-hover:opacity-100 transition-opacity duration-500 font-medium">
                  <span class="flex items-center space-x-3">
                    <span>Explorar todos los servicios</span>
                    <Icon name="lucide:sparkles" class="w-5 h-5" />
                  </span>
                </span>
              </button>
            </NuxtLink>
            <!-- Floating particles -->
            <div class="absolute -top-2 -right-2 w-3 h-3 bg-pink-400 rounded-full animate-ping"></div>
            <div class="absolute -bottom-2 -left-2 w-2 h-2 bg-orange-400 rounded-full animate-ping" style="animation-delay: 1s;"></div>
          </div>
        </div>
      </div>
    </section>

    <!-- Productos Section -->
    <section id="productos" class="py-16 md:py-24 px-4 md:px-6 bg-gradient-to-br from-white to-purple-50/30">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
          <h2 
            class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold mb-6"
            data-aos="fade-up"
            data-aos-duration="1000"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Nuestros Productos
            </span>
          </h2>
          <p 
            class="text-lg md:text-xl text-gray-600 max-w-2xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="1000"
          >
            Los mejores productos para tu cuidado personal
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8">
          <div 
            v-for="(producto, index) in productos"
            :key="index"
            class="group bg-white rounded-3xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2"
            data-aos="fade-up"
            :data-aos-delay="index * 150"
            data-aos-duration="800"
          >
            <div class="h-48 overflow-hidden">
              <img 
                :src="producto.imagen" 
                :alt="producto.nombre"
                class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
              />
            </div>
            <div class="p-6">
              <div class="flex items-center justify-between mb-3">
                <span class="text-xs font-semibold uppercase tracking-wider text-pink-500 bg-pink-50 px-3 py-1 rounded-full">
                  {{ producto.categoria }}
                </span>
                <Icon :name="producto.icon" class="w-5 h-5 text-pink-500" />
              </div>
              <h3 class="text-lg font-bold mb-3 text-gray-800">
                {{ producto.nombre }}
              </h3>
              <p class="text-sm mb-4 text-gray-600">
                {{ producto.descripcion }}
              </p>
              <div class="flex items-center justify-between">
                <span class="text-2xl font-bold bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
                  {{ producto.precio }}
                </span>
                <button 
                  @click="addToCart(producto)"
                  class="p-3 bg-gradient-to-r from-pink-500 to-orange-500 text-white rounded-full hover:shadow-lg transform hover:scale-110 transition-all duration-300"
                >
                  <Icon name="lucide:shopping-cart" class="w-5 h-5" />
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Contacto Section -->
    <section id="contacto" class="py-16 md:py-24 px-4 md:px-6 bg-gradient-to-br from-pink-50/30 to-white">
      <div class="max-w-6xl mx-auto">
        <div class="text-center mb-16">
          <h2 
            class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold mb-6"
            data-aos="fade-up"
            data-aos-duration="1000"
          >
            <span class="bg-gradient-to-r from-pink-600 to-orange-500 bg-clip-text text-transparent">
              Encuéntranos
            </span>
          </h2>
          <p 
            class="text-lg md:text-xl text-gray-600 max-w-2xl mx-auto"
            data-aos="fade-up"
            data-aos-delay="200"
            data-aos-duration="1000"
          >
            Ven a visitarnos y empieza tu transformación
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12">
          <div 
            class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50"
            data-aos="slide-right"
            data-aos-duration="800"
          >
            <h3 class="text-2xl font-bold mb-8 bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
              Información de Contacto
            </h3>
            
            <div class="space-y-6">
              <div class="flex items-center">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                  <Icon name="lucide:map-pin" class="w-6 h-6 text-white" />
                </div>
                <div>
                  <p class="font-semibold text-gray-800">Dirección</p>
                  <p class="text-gray-600">Calle Belleza 123, Ciudad</p>
                </div>
              </div>
              
              <div class="flex items-center">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                  <Icon name="lucide:phone" class="w-6 h-6 text-white" />
                </div>
                <div>
                  <p class="font-semibold text-gray-800">Teléfono</p>
                  <p class="text-gray-600">+1 234 567 8900</p>
                </div>
              </div>
              
              <div class="flex items-center">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                  <Icon name="lucide:mail" class="w-6 h-6 text-white" />
                </div>
                <div>
                  <p class="font-semibold text-gray-800">Email</p>
                  <p class="text-gray-600">hola@todabonita.com</p>
                </div>
              </div>
              
              <div class="flex items-center">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center mr-4 shadow-lg">
                  <Icon name="lucide:clock" class="w-6 h-6 text-white" />
                </div>
                <div>
                  <p class="font-semibold text-gray-800">Horario</p>
                  <p class="text-gray-600">Lun - Sab: 9:00 AM - 8:00 PM</p>
                  <p class="text-gray-600">Dom: 10:00 AM - 6:00 PM</p>
                </div>
              </div>
            </div>
          </div>

          <div 
            class="bg-white rounded-3xl p-8 shadow-lg border border-pink-100/50"
            data-aos="slide-left"
            data-aos-duration="800"
          >
            <h3 class="text-2xl font-bold mb-8 bg-gradient-to-r from-pink-500 to-orange-500 bg-clip-text text-transparent">
              Síguenos
            </h3>
            
            <div class="grid grid-cols-3 gap-4 mb-8">
              <button 
                @click="openSocial('instagram')"
                class="p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-110 group border border-pink-200/50"
              >
                <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center group-hover:scale-110 transition-transform mx-auto">
                  <Icon name="lucide:instagram" class="w-4 h-4 text-white" />
                </div>
              </button>
              <button 
                @click="openSocial('facebook')"
                class="p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-110 group border border-pink-200/50"
              >
                <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center group-hover:scale-110 transition-transform mx-auto">
                  <Icon name="lucide:facebook" class="w-4 h-4 text-white" />
                </div>
              </button>
              <button 
                @click="openSocial('tiktok')"
                class="p-4 bg-gradient-to-br from-pink-100 to-orange-100 rounded-2xl hover:from-pink-200 hover:to-orange-200 transition-all transform hover:scale-110 group border border-pink-200/50"
              >
                <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-pink-500 to-orange-500 flex items-center justify-center group-hover:scale-110 transition-transform mx-auto">
                  <Icon name="lucide:music" class="w-4 h-4 text-white" />
                </div>
              </button>
            </div>

            <div class="bg-gradient-to-r from-pink-100 to-orange-100 rounded-2xl p-6 border border-pink-200/50">
              <p class="text-center font-semibold text-gray-700 mb-4">
                ¿Lista para tu transformación?
              </p>
              <NuxtLink to="/reserva">
                <button 
                  class="w-full py-4 bg-gradient-to-r from-pink-500 to-orange-500 text-white font-bold rounded-2xl shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300"
                >
                  Agenda Tu Cita Ahora
                </button>
              </NuxtLink>
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
  title: 'Toda Bonita - Salón de Belleza',
  meta: [
    { name: 'description', content: 'Tu salón de belleza de confianza donde cada visita es una experiencia única. Especialistas en peluquería, manicura, extensiones de pestañas y más.' },
    { name: 'keywords', content: 'salón de belleza, peluquería, manicura, extensiones de pestañas, limpiezas faciales, masajes, tratamientos de belleza' },
    { property: 'og:title', content: 'Toda Bonita - Salón de Belleza' },
    { property: 'og:description', content: 'La etapa de ser nuestra clienta... ¡Te recomiendo no saltártela!' },
    { property: 'og:type', content: 'website' },
    { name: 'twitter:card', content: 'summary_large_image' }
  ]
})

// Datos
const transformaciones = [
  {
    titulo: 'Cambio de Look Completo',
    descripcion: 'De cabello maltratado y sin vida a un hermoso bob saludable y brillante',
    antes: 'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=400&h=300&fit=crop&crop=center',
    despues: '/img/servicio_peluqueria.jpg'
  },
  {
    titulo: 'Transformación Capilar',
    descripcion: 'Reparación completa de cabello dañado por químicos',
    antes: 'https://images.unsplash.com/photo-1530884698386-d42ad3199b1d?w=400&h=300&fit=crop&crop=center',
    despues: '/img/servicio_peluqueria4.jpg'
  },
  {
    titulo: 'Rescate de Cabello Quebradizo',
    descripcion: 'Desde cabello seco y quebradizo hasta melena sedosa y saludable',
    antes: 'https://images.unsplash.com/photo-1560070094-e1f2ddec4337?w=400&h=300&fit=crop&crop=center',
    despues: '/img/servicio_unas1.jpg'
  }
]

const servicios = [
  {
    titulo: 'Peluquería',
    icon: 'lucide:scissors',
    subservicios: ['Botox capilar', 'Keratina', 'Mechas', 'Tinte', 'Alisado']
  },
  {
    titulo: 'Extensiones de Pestañas',
    icon: 'lucide:eye',
    subservicios: ['Clásicas', 'Volumen', 'Lifting', 'Mantenimiento']
  },
  {
    titulo: 'Manicura',
    icon: 'lucide:hand',
    subservicios: ['Gel', 'Semipermanente', 'Diseños', 'Spa de manos']
  },
  {
    titulo: 'Tratamientos Faciales',
    icon: 'lucide:sparkles',
    subservicios: ['Limpieza profunda', 'Hidratación', 'Anti-edad', 'Acné']
  },
  {
    titulo: 'Depilaciones',
    icon: 'lucide:zap',
    subservicios: ['Cera', 'Láser', 'Hilo', 'Zona completa']
  },
  {
    titulo: 'Mascarillas Personalizadas',
    icon: 'lucide:heart',
    subservicios: ['Oro', 'Colágeno', 'Vitamina C', 'Ácido hialurónico']
  },
  {
    titulo: 'Masajes',
    icon: 'lucide:flower',
    subservicios: ['Relajante', 'Descontracturante', 'Piedras calientes', 'Aromaterapia']
  },
  {
    titulo: 'Servicios Especiales',
    icon: 'lucide:star',
    subservicios: ['Extracción tinte negro', 'Consultoría belleza', 'Paquetes VIP', 'Eventos']
  }
]

const productos = [
  { 
    nombre: 'Serum Capilar Reparador', 
    precio: '$45', 
    categoria: 'Cabello',
    icon: 'lucide:droplets',
    descripcion: 'Repara y fortalece el cabello dañado',
    imagen: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Mascarilla Hidratante', 
    precio: '$38', 
    categoria: 'Skincare',
    icon: 'lucide:sparkles',
    descripcion: 'Hidratación profunda para todo tipo de piel',
    imagen: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Aceite de Argán Premium', 
    precio: '$52', 
    categoria: 'Cabello',
    icon: 'lucide:leaf',
    descripcion: 'Aceite natural para nutrición capilar',
    imagen: 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Crema Anti-edad', 
    precio: '$68', 
    categoria: 'Skincare',
    icon: 'lucide:timer',
    descripcion: 'Reduce líneas de expresión y arrugas',
    imagen: 'https://images.unsplash.com/photo-1570194065650-d99fb4bedf0a?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Protector Térmico', 
    precio: '$35', 
    categoria: 'Cabello',
    icon: 'lucide:shield',
    descripcion: 'Protege el cabello del calor del secador',
    imagen: 'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=400&h=300&fit=crop&crop=center'
  },
  { 
    nombre: 'Tónico Facial', 
    precio: '$28', 
    categoria: 'Skincare',
    icon: 'lucide:waves',
    descripcion: 'Equilibra y refresca la piel',
    imagen: 'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=400&h=300&fit=crop&crop=center'
  }
]

// Funciones
const scrollToSection = (sectionId) => {
  const element = document.getElementById(sectionId)
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' })
  }
}

const addToCart = (producto) => {
  alert(`${producto.nombre} agregado al carrito!`)
}

const openSocial = (platform) => {
  const urls = {
    instagram: 'https://instagram.com/todabonita',
    facebook: 'https://facebook.com/todabonita',
    tiktok: 'https://tiktok.com/@todabonita'
  }
  
  if (urls[platform]) {
    window.open(urls[platform], '_blank')
  }
}

const bookAppointment = () => {
  alert('¡Redirección a sistema de reservas!')
}
</script>