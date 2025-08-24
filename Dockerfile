# Use Node.js 18 LTS
FROM node:18-alpine

# Install build dependencies for native modules
RUN apk add --no-cache python3 make g++ && ln -sf python3 /usr/bin/python

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies using npm install (not ci) to avoid native binding issues
RUN npm cache clean --force && \
    rm -rf node_modules package-lock.json && \
    npm install --production=false && \
    npm run postinstall

# Copy source code
COPY . .

# Create missing TypeScript config files that nuxt prepare might not generate in Docker
RUN mkdir -p .nuxt && \
    echo '{"extends": "./tsconfig.json","compilerOptions": {"composite": false,"types": ["node"]},"include": ["../plugins/**/*","../components/**/*","../layouts/**/*","../pages/**/*","../composables/**/*","../utils/**/*","../middleware/**/*","../assets/**/*"]}' > .nuxt/tsconfig.app.json && \
    echo '{"compilerOptions": {"allowJs": true,"esModuleInterop": true,"forceConsistentCasingInFileNames": true,"isolatedModules": true,"jsx": "preserve","lib": ["ESNext", "DOM"],"module": "ESNext","moduleDetection": "force","moduleResolution": "Bundler","noEmit": true,"resolveJsonModule": true,"skipLibCheck": true,"strict": true,"target": "ESNext","verbatimModuleSyntax": true}}' > .nuxt/tsconfig.shared.json && \
    echo '{"extends": "./tsconfig.shared.json","compilerOptions": {"composite": true,"module": "ESNext","moduleResolution": "Bundler","types": ["node"]},"include": ["../nuxt.config.ts","../tailwind.config.js","../vite.config.ts"]}' > .nuxt/tsconfig.node.json

# Build the application
RUN npm run build

# Remove dev dependencies and clean cache
RUN npm prune --production && \
    npm cache clean --force

# Expose port
EXPOSE 3000

# Set environment to production
ENV NODE_ENV=production
ENV NITRO_PORT=3000
ENV NITRO_HOST=0.0.0.0

# Start the application
CMD ["npm", "run", "preview"]