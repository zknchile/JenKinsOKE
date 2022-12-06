FROM ubuntu

# Instalamos nginx y Actualizamos el OS 
RUN apt-get -y update && apt-get -y install nginx

# Copiamos nuevas configuraciones y archivo index
COPY default /etc/nginx/sites-available/default
COPY index.html /usr/share/nginx/html/index.html

# Exponemos el pruerto 80 bajo protocolo TCP
EXPOSE 80/tcp

#Ejecutamos el servicios nginx
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
