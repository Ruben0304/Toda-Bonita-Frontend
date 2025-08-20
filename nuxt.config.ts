// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  modules: [
    '@nuxtjs/tailwindcss',
    '@nuxt/icon',
    '@nuxtjs/google-fonts'
  ],
  icon: {
    provider: 'iconify',
    serverBundle: {
      collections: ['lucide', 'heroicons', 'tabler']
    }
  },
  css: ['~/assets/main.css'],
  googleFonts: {
    families: {
      'Playfair Display': [300, 400, 500, 600, 700],
      'Inter': [300, 400, 500, 600, 700],
      'Montserrat': [300, 400, 500, 600, 700]
    }
  },
  app: {
    head: {
      link: [
        { rel: 'stylesheet', href: 'https://unpkg.com/aos@2.3.4/dist/aos.css' }
      ],
      script: [
        { src: 'https://unpkg.com/aos@2.3.4/dist/aos.js', body: true }
      ]
    }
  }
})
