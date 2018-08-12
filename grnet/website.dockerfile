############################################################
# Dockerfile to build and server LambdaSpace's website
############################################################

# Use the Node image to build the website's assets
FROM node:10-stretch as asset_builder

RUN git clone https://github.com/lambdaspace/new_website.git

# Install packages and build assets
WORKDIR /new_website
RUN yarn install
RUN yarn build


# Set the base image to Debian
FROM nginx:alpine

################## BEGIN INSTALLATION ######################
RUN apk add --update --no-cache ca-certificates

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY website-nginx.conf /etc/nginx/nginx.conf

WORKDIR /usr/share/nginx/html
RUN rm *
COPY --from=asset_builder /new_website/* ./

################## INSTALLATION END ######################

EXPOSE 80 443
CMD nginx -g "daemon off;"