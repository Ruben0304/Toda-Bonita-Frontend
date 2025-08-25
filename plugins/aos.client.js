export default defineNuxtPlugin(() => {
  if (process.client) {
    // @ts-ignore - AOS is loaded via CDN
    if (typeof window !== 'undefined' && window.AOS) {
      window.AOS.init({
        duration: 800,
        easing: 'ease-in-out-cubic',
        once: true,
        offset: 100,
        delay: 0,
        anchorPlacement: 'top-bottom'
      })
    }
  }
})