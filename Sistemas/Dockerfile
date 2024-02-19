FROM httpd:latest
COPY ./contenidoWeb /usr/local/apache2/docs
RUN mkdir -p /usr/local/apache2/db
CMD [ "apache2ctl", "-D", "FOREGROUND"]