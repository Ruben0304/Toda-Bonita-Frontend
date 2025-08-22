# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Nuxt 4 application for "Toda Bonita" beauty salon website. It's a multi-page application featuring a beauty salon's services, products, gallery, booking system, and admin panel with modern aesthetic design using custom CSS animations, Tailwind CSS, and advanced libraries.

## Development Commands

- **Start development server**: `npm run dev` (runs on http://localhost:3000)
- **Build for production**: `npm run build`
- **Preview production build**: `npm run preview`
- **Generate static site**: `npm run generate`
- **Prepare Nuxt**: `npm run postinstall` (runs automatically after npm install)

## Architecture & Structure

### Key Technologies
- **Nuxt 4**: Vue.js meta-framework with auto-imports and file-based routing
- **Vue 3**: Composition API used throughout components
- **Tailwind CSS**: Utility-first CSS framework
- **Three.js**: 3D background animations and effects
- **GSAP**: Advanced animations library
- **AOS**: Animate On Scroll library for scroll-triggered animations
- **Lenis**: Smooth scrolling library
- **Nuxt Icon**: Icon management with Iconify integration (Lucide, Heroicons, Tabler collections)
- **Google Fonts**: Typography with Playfair Display, Inter, and Montserrat
- **Custom CSS**: Extensive custom animations and styling in `assets/main.css`

### Project Structure
- **`pages/`**: File-based routing structure:
  - `index.vue`: Main landing page with hero section and Three.js background
  - `servicios.vue`: Services listing page
  - `productos.vue`: Products catalog page
  - `galeria.vue`: Gallery/transformations showcase
  - `reserva.vue`: Booking/reservation system
  - `contacto.vue`: Contact information page
  - `carrito.vue`: Shopping cart functionality
  - `servicio/[id].vue`: Dynamic service detail pages
  - `producto/[id].vue`: Dynamic product detail pages
  - `admin/index.vue`: Admin dashboard with product and reservation management
- **`layouts/default.vue`**: Global layout with Navigation and Footer, optimized spacing
- **`components/`**: Reusable components:
  - `Navigation.vue`: Site navigation (desktop sidebar + mobile top nav)
  - `Footer.vue`: Site footer
  - `ThreeBackground.vue`: 3D background component with Three.js
  - `HeroAnimations.vue`: Hero section animation component
  - `AdminProductos.vue`: Admin product management
  - `AdminReservas.vue`: Admin reservation management
- **`plugins/`**: Client-side plugins:
  - `aos.client.js/ts`: AOS animation initialization
- **`assets/main.css`**: Custom CSS with:
  - CSS custom properties for brand colors (pink/orange/green pastels)
  - Custom animations (fadeInUp, float, pulse, shimmer, gradientShift)
  - Responsive design utilities
  - Special effects (liquid buttons, image zoom, gradient text)

### Styling System
- **Brand colors**: Defined as CSS custom properties in `:root`
  - Primary: Pink to orange gradients (`from-pink-500 to-orange-500`)
  - Background: Subtle white to soft pink gradient (`from-white via-pink-50/20 to-orange-50/10`)
  - Accent colors: `--pink-pastel`, `--sage`, `--cream`, `--lavender`
- **Design patterns**: 
  - Cards with hover effects and shadow elevation
  - Gradient text and backgrounds
  - Smooth animations and transitions
  - Rounded corners (rounded-3xl, rounded-2xl)
- **Responsive**: Mobile-first approach with desktop sidebar navigation
- **Typography**: Multiple font families (Playfair Display for headings, Inter for body, Montserrat for accents)

### Nuxt Configuration
- **Modules**: 
  - `@nuxtjs/tailwindcss`: Tailwind CSS integration
  - `@nuxt/icon`: Icon management with Iconify (Lucide, Heroicons, Tabler)
  - `@nuxtjs/google-fonts`: Web font loading
- **Auto-imports**: Components are automatically imported (no need for explicit imports)
- **DevTools**: Enabled for development
- **CSS**: Global styles loaded from `~/assets/main.css`
- **External libraries**: AOS CSS and JS loaded via CDN for animations

## Development Notes

- **Architecture**: Multi-page application with dedicated pages for different functionality
- **Components**: Vue 3 Composition API with `<script setup>`
- **SEO**: Optimized with `useHead()` for meta tags and page title
- **Icons**: Uses Nuxt Icon with Iconify integration (Lucide icons primarily)
- **Styling**: Custom scrollbar styling and smooth scroll behavior implemented
- **Animations**: 
  - Three.js for 3D background effects
  - AOS for scroll-triggered animations
  - GSAP for advanced animations
  - Custom CSS animations for enhanced user experience
- **Responsive**: Mobile-responsive design with different navigation patterns for mobile/desktop
- **Admin functionality**: Separate admin pages for managing products and reservations
- **E-commerce features**: Product pages, shopping cart, and reservation system

## Recent Changes (Latest Update)

- **Expanded to multi-page application**: Added dedicated pages for services, products, gallery, reservations, contact, and admin
- **Enhanced functionality**: 
  - Added shopping cart system
  - Implemented booking/reservation system
  - Created admin dashboard for product and reservation management
  - Added dynamic routing for individual products and services
- **Improved libraries and animations**:
  - Integrated Three.js for 3D background effects
  - Added GSAP for advanced animations
  - Implemented AOS for scroll-triggered animations
  - Enhanced icon system with Nuxt Icon and Iconify
- **Typography and design**: 
  - Added multiple Google Fonts (Playfair Display, Inter, Montserrat)
  - Enhanced visual hierarchy and design consistency
- **Component structure**: Added specialized admin components and hero animations

### Navigation & Layout Fixes (January 2025)

- **Fixed static navigation**: Removed problematic hover effects that caused sidebar movement/floating
  - Eliminated `.modern-sidebar:hover` transform and scale animations
  - Removed `.nav-item-enhanced:hover` glow animations that caused position shifts
  - Navigation now remains completely static and doesn't move on hover or scroll
- **Corrected layout spacing**: Fixed content and footer positioning relative to 288px sidebar
  - Updated layout from `lg:ml-64` to `lg:ml-72` (288px) to match actual sidebar width (w-72)
  - Added proper content padding with `lg:pr-6` for optimal spacing
  - Fixed footer positioning with `lg:ml-72` to prevent it from going behind navigation
  - Updated responsive CSS breakpoints to use correct 288px margin
- **Layout structure improvements**:
  - Main content properly utilizes space to the right of sidebar
  - Footer correctly respects sidebar space instead of overlapping
  - Consistent spacing throughout the application