# Pull the Node.js image
FROM node:18-alpine as builder

# Create a Docker working directory
WORKDIR /app

# Copy package.json and package-lock.json dependencies files 
COPY package*.json ./

# Install dependencies inside Docker
RUN npm install

# Copy the application source code
COPY . .

RUN npm run build

# Pull Nginx Image
FROM nginx:alpine

COPY --from=builder app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]