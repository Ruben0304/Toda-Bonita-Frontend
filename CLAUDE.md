# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Nuxt 4 application for "Toda Bonita" beauty salon website. It's a single-page application showcasing beauty services, transformations, products, and contact information with a modern, aesthetic design using custom CSS animations and Tailwind CSS.

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
- **Custom CSS**: Extensive custom animations and styling in `assets/main.css`

### Project Structure
- **`pages/index.vue`**: Main landing page with all sections integrated directly:
  - Hero section with elegant gradient design
  - Transformaciones (before/after showcase)
  - Servicios (services grid with icons)
  - Productos (product showcase)
  - Contacto (contact information and social links)
- **`layouts/default.vue`**: Global layout with Navigation and Footer, optimized spacing
- **`components/`**: Only reusable components:
  - `Navigation.vue`: Site navigation (desktop sidebar + mobile top nav)
  - `Footer.vue`: Site footer
  - `ThreeBackground.vue`: 3D background component (if used)
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
- **Typography**: Inter font family for clean, modern look

### Nuxt Configuration
- **Modules**: `@nuxtjs/tailwindcss` for Tailwind CSS integration
- **Auto-imports**: Components are automatically imported (no need for explicit imports)
- **DevTools**: Enabled for development
- **CSS**: Global styles loaded from `~/assets/main.css`

## Development Notes

- **Architecture**: Single-page application with all sections in `pages/index.vue`
- **Components**: Vue 3 Composition API with `<script setup>`
- **SEO**: Optimized with `useHead()` for meta tags and page title
- **Icons**: Uses emoji icons instead of external icon libraries for better performance
- **Styling**: Custom scrollbar styling and smooth scroll behavior implemented
- **Animations**: Extensive use of CSS animations for enhanced user experience
- **Responsive**: Mobile-responsive design with different navigation patterns for mobile/desktop
- **Performance**: Eliminated unnecessary section components, keeping only reusable components

## Recent Changes (Latest Update)

- **Reorganized structure**: Moved all sections from separate components into `pages/index.vue`
- **Simplified components folder**: Only contains reusable components (Navigation, Footer, ThreeBackground)
- **Improved design**: 
  - Changed background to subtle white-to-pink gradient (less saturated)
  - Fixed navigation spacing issues
  - Replaced external icons with emoji for better reliability
  - Enhanced typography with Inter font
  - Improved card hover effects and shadows
- **Fixed layout issues**: Removed unwanted spacing between navigation and content

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