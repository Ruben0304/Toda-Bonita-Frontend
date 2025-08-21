<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/20 to-orange-50/10">
    <Navigation />
    <main class="lg:ml-72 min-h-screen">
      <div class="lg:pr-6">
        <slot />
      </div>
    </main>
    <footer class="lg:ml-72">
      <Footer />
    </footer>
  </div>
</template>

<script setup>
// Importar componentes automáticamente via Nuxt auto-imports
</script>