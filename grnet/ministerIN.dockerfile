############################################################
# Dockerfile to build the MinisterIN service
############################################################

# Use the alpine Node.js base image
FROM node:21-alpine

################## BEGIN INSTALLATION ######################

# Update repositories and install git
RUN apk add --update --no-cache git

# Clone repo
RUN git clone https://github.com/lambdaspace/MinisterIN.git
COPY credentials/MinisterIn/ MinisterIN/

# Install dependencies
WORKDIR MinisterIN
RUN yarn install

# Open port 7777
EXPOSE 7777

################## INSTALLATION END ######################
USER 1000
CMD node MinisterIN.js
