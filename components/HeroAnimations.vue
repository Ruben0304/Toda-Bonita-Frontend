<template>
  <div class="hero-container relative overflow-hidden">
    <!-- Elementos decorativos sutiles -->
    <div class="absolute top-10 right-10 w-32 h-32 rounded-full opacity-25 animate-float-slow">
      <div class="w-full h-full rounded-full bg-gradient-to-br from-pink-300/30 to-orange-300/30 blur-xl"></div>
    </div>
    
    <div class="absolute bottom-20 left-10 w-24 h-24 rounded-full opacity-20 animate-float-medium">
      <div class="w-full h-full rounded-full bg-gradient-to-br from-purple-300/30 to-cyan-300/30 blur-lg"></div>
    </div>
    
    <div class="absolute top-1/3 left-1/4 w-16 h-16 rounded-full opacity-15 animate-float-fast">
      <div class="w-full h-full rounded-full bg-gradient-to-br from-yellow-300/30 to-pink-300/30 blur-md"></div>
    </div>

    <!-- Contenido principal con animaciones AOS sutiles -->
    <div class="relative z-10 text-center px-6 max-w-4xl mx-auto">
      <!-- Logo decorativo con animación sutil -->
      <div 
        class="mx-auto mb-6 w-16 h-16 rounded-2xl bg-white/95 flex items-center justify-center shadow-lg border border-pink-100"
        data-aos="fade-down"
        data-aos-duration="800"
      >
        <img 
          src="/img/logolisto.png" 
          alt="Toda Bonita Logo" 
          class="w-12 h-12 object-contain"
        />
      </div>

      <!-- Título principal con animación sutil -->
      <div class="overflow-hidden mb-4">
        <slot name="text-reveal"></slot>
      </div>

      <!-- Subtítulo con animación sutil -->
      <p 
        class="text-xl lg:text-2xl mb-4 text-gray-700 font-light"
        data-aos="fade-up"
        data-aos-delay="200"
        data-aos-duration="800"
      >
        <slot name="subtitle"></slot>
      </p>

      <!-- Separador decorativo sutil -->
      <div 
        class="w-16 h-0.5 bg-gradient-to-r from-pink-400 to-orange-400 mx-auto rounded-full mb-6" 
        data-aos="width"
        data-aos-delay="400"
        data-aos-duration="600"
      ></div>

      <!-- Botones con animación sutil -->
      <div 
        class="flex flex-col sm:flex-row gap-4 justify-center items-center"
        data-aos="fade-up"
        data-aos-delay="600"
        data-aos-duration="800"
      >
        <slot name="buttons"></slot>
      </div>
    </div>
  </div>
</template>

<script setup>
// No se necesitan props ni lógica adicional
</script>

<style scoped>
.hero-container {
  min-height: 90vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Animaciones sutiles */
@keyframes float-slow {
  0%, 100% { transform: translateY(0) translateX(0); }
  50% { transform: translateY(-10px) translateX(5px); }
}

@keyframes float-medium {
  0%, 100% { transform: translateY(0) translateX(0); }
  50% { transform: translateY(-15px) translateX(-5px); }
}

@keyframes float-fast {
  0%, 100% { transform: translateY(0) translateX(0); }
  50% { transform: translateY(-8px) translateX(8px); }
}

.animate-float-slow {
  animation: float-slow 8s ease-in-out infinite;
}

.animate-float-medium {
  animation: float-medium 6s ease-in-out infinite;
}

.animate-float-fast {
  animation: float-fast 4s ease-in-out infinite;
}

/* Animación personalizada para AOS */
[data-aos="width"] {
  width: 0;
  transition-property: width;
}

[data-aos="width"].aos-animate {
  width: 16rem;
}
</style>