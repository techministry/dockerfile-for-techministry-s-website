############################################################
# Dockerfile to build and server LambdaSpace's website
############################################################

## Builder
# Use the Node image to build the website's assets
FROM node:16-stretch as asset_builder

RUN git clone https://github.com/lambdaspace/new_website.git

# Install packages and build assets
WORKDIR /new_website
RUN yarn install
RUN yarn build

## Website container
FROM nginx:alpine

RUN apk add --update --no-cache ca-certificates

# Copy config from host
COPY website-nginx.conf /etc/nginx/nginx.conf
# Copy assets from builer
WORKDIR /usr/share/nginx/html
RUN rm *
COPY --from=asset_builder /new_website/ ./

EXPOSE 80 443