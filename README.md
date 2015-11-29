# Dockerfile for deploying techministry's website

## Requirements
* Docker: https://docs.docker.com/installation/

## How to build and run the container
* Navigate to the place where you cloned the repo
* Build the image `docker build -t website .` (you may have to add `sudo` in front of the command)
* Run the container `docker run --name website --restart=always -p 2121:80 -t -i -d website` (remove -d if you don't want to run the container at the background)
