import AOS from 'aos'

export default defineNuxtPlugin(() => {
  AOS.init({
    duration: 1000,
    easing: 'ease-out-cubic',
    once: true,
    offset: 100,
    delay: 0,
    anchorPlacement: 'top-bottom'
  })
})