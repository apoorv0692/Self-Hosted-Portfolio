FROM nginx
RUN apt-get update
RUN apt-get install -y --no-install-recommends procps
COPY ./portfolio /var/www/html/portfolio/
RUN rm -rf /etc/nginx/sites-enabled/default.conf
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
