<template>
  <div ref="container" class="absolute inset-0 overflow-hidden opacity-20"></div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import * as THREE from 'three'

const container = ref(null)
let scene, camera, renderer, particles, morphingShapes, floatingOrbs
let animationId
let time = 0

onMounted(() => {
  if (process.client) {
    initThree()
    animate()
  }
})

onUnmounted(() => {
  if (animationId) {
    cancelAnimationFrame(animationId)
  }
  if (renderer) {
    renderer.dispose()
  }
})

const initThree = () => {
  // Scene
  scene = new THREE.Scene()

  // Camera
  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
  camera.position.z = 8

  // Renderer
  renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setClearColor(0x000000, 0)
  container.value.appendChild(renderer.domElement)

  createParticles()
  createMorphingShapes()
  createFloatingOrbs()

  // Handle resize
  window.addEventListener('resize', onWindowResize, false)
}

const createParticles = () => {
  const particleCount = 200
  const geometry = new THREE.BufferGeometry()
  const positions = new Float32Array(particleCount * 3)
  const colors = new Float32Array(particleCount * 3)
  const sizes = new Float32Array(particleCount)

  for (let i = 0; i < particleCount; i++) {
    const i3 = i * 3
    positions[i3] = (Math.random() - 0.5) * 30
    positions[i3 + 1] = (Math.random() - 0.5) * 30
    positions[i3 + 2] = (Math.random() - 0.5) * 30

    // Beauty salon pink/coral/gold colors
    const colorVariant = Math.random()
    const color = new THREE.Color()
    if (colorVariant < 0.4) {
      color.setHSL(0.9, 0.6, 0.7) // Pink
    } else if (colorVariant < 0.7) {
      color.setHSL(0.08, 0.8, 0.7) // Coral/Orange
    } else {
      color.setHSL(0.15, 0.9, 0.8) // Gold
    }
    
    colors[i3] = color.r
    colors[i3 + 1] = color.g
    colors[i3 + 2] = color.b
    sizes[i] = Math.random() * 3 + 1
  }

  geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3))
  geometry.setAttribute('color', new THREE.BufferAttribute(colors, 3))
  geometry.setAttribute('size', new THREE.BufferAttribute(sizes, 1))

  const material = new THREE.PointsMaterial({
    size: 2,
    vertexColors: true,
    transparent: true,
    opacity: 0.8,
    sizeAttenuation: true
  })

  particles = new THREE.Points(geometry, material)
  scene.add(particles)
}

const createMorphingShapes = () => {
  morphingShapes = new THREE.Group()
  
  for (let i = 0; i < 5; i++) {
    const geometry = new THREE.SphereGeometry(Math.random() * 2 + 1, 16, 12)
    const material = new THREE.MeshBasicMaterial({
      color: new THREE.Color().setHSL(0.9 + Math.random() * 0.1, 0.5, 0.7),
      transparent: true,
      opacity: 0.3,
      wireframe: true
    })
    
    const sphere = new THREE.Mesh(geometry, material)
    sphere.position.set(
      (Math.random() - 0.5) * 20,
      (Math.random() - 0.5) * 20,
      (Math.random() - 0.5) * 20
    )
    
    morphingShapes.add(sphere)
  }
  
  scene.add(morphingShapes)
}

const createFloatingOrbs = () => {
  floatingOrbs = new THREE.Group()
  
  for (let i = 0; i < 8; i++) {
    const geometry = new THREE.SphereGeometry(0.5, 32, 32)
    const material = new THREE.MeshBasicMaterial({
      color: new THREE.Color().setHSL(0.08 + Math.random() * 0.1, 0.8, 0.6),
      transparent: true,
      opacity: 0.6
    })
    
    const orb = new THREE.Mesh(geometry, material)
    orb.position.set(
      (Math.random() - 0.5) * 25,
      (Math.random() - 0.5) * 25,
      (Math.random() - 0.5) * 15
    )
    
    orb.userData = {
      originalY: orb.position.y,
      speed: Math.random() * 0.02 + 0.01,
      amplitude: Math.random() * 2 + 1
    }
    
    floatingOrbs.add(orb)
  }
  
  scene.add(floatingOrbs)
}

const animate = () => {
  animationId = requestAnimationFrame(animate)
  time += 0.01

  if (particles) {
    particles.rotation.x += 0.0005
    particles.rotation.y += 0.001
    
    // Gentle wave motion for particles
    const positions = particles.geometry.attributes.position.array
    for (let i = 1; i < positions.length; i += 3) {
      positions[i] += Math.sin(time + positions[i] * 0.1) * 0.002
    }
    particles.geometry.attributes.position.needsUpdate = true
  }

  if (morphingShapes) {
    morphingShapes.children.forEach((shape, index) => {
      shape.rotation.x += 0.01
      shape.rotation.y += 0.005
      shape.position.y += Math.sin(time + index) * 0.02
      
      // Gentle scaling
      const scale = 1 + Math.sin(time * 2 + index) * 0.1
      shape.scale.setScalar(scale)
    })
  }

  if (floatingOrbs) {
    floatingOrbs.children.forEach((orb) => {
      orb.position.y = orb.userData.originalY + Math.sin(time * orb.userData.speed) * orb.userData.amplitude
      orb.rotation.x += 0.005
      orb.rotation.z += 0.003
    })
  }

  renderer.render(scene, camera)
}

const onWindowResize = () => {
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()
  renderer.setSize(window.innerWidth, window.innerHeight)
}
</script>