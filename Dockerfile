# See "Using Docker to Run a Simple Nginx Server" at 
# https://medium.com/myriatek/using-docker-to-run-a-simple-nginx-server-75a48d74500b
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html