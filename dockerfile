    # Stage 1: Build the React application
    from node:alpine as build
    WORKDIR /app
    COPY package.json ./
    RUN npm install --force
    COPY . .
    RUN npm run build

    # Stage 2: Serve the application with Nginx
    from nginx:alpine
    COPY --from=build app/build /usr/share/nginx/html
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]