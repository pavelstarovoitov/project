FROM nginx:1.24.0-alpine   
COPY index.html /usr/share/nginx/html   
COPY image.png /usr/share/nginx/html
EXPOSE 8000 
CMD ["nginx", "-g", "daemon off;"] 
