FROM httpd:2.4.55-alpine
WORKDIR /usr/local/apache2/htdocs/
COPY ./public_html .
LABEL org.opencontainers.image.source=https://github.com/VLRuben/hello-terraform
EXPOSE 80
