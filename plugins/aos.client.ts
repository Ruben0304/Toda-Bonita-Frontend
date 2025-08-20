import AOS from 'aos'
import 'aos/dist/aos.css'

export default defineNuxtPlugin(() => {
  AOS.init({
    duration: 800,
    easing: 'ease-in-out-cubic',
    once: true,
    offset: 100,
    delay: 0,
    anchorPlacement: 'top-bottom'
  })
})