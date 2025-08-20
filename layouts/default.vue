<template>
  <div class="min-h-screen bg-gradient-to-br from-white via-pink-50/20 to-orange-50/10">
    <Navigation />
    <main class="lg:ml-64">
      <slot />
    </main>
    <Footer />
  </div>
</template>

<script setup>
// Importar componentes automáticamente via Nuxt auto-imports
</script>