# Load nginx docker image
FROM nginx:1.17.9

# set default index webpage
RUN rm /usr/share/nginx/html/index.html

COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80