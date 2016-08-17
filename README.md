# Dockerfile for deploying techministry's website and MinisterIN service

## Requirements
* Docker: https://docs.docker.com/installation/

## How to build and run the containers
* Navigate to the place where you cloned the repo

### Website
* Build the image `docker build -t website .` (you may have to add `sudo` in front of the command)
* Run the container `docker run --name website --restart=always -p 2121:80 -t -i -d website` (remove -d if you don't want to run the container at the background)

### MinisterIN
* Build the image `docker build -f MinisterIN-Dockerfile -t ministerin .` (you may have to add `sudo` in front of the command)
* Run the container `docker run --name ministerin --restart=always -P -t -i -d ministerin` (remove -d if you don't want to run the container at the background)
