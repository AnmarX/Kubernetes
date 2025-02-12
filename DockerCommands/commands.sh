#list images
docker images

#create new container
docker run 

#list runinng containers
docker ps

#list all the containers
docker ps -a

#execute commands on containers/access container shell
docker exec -it <container name> /bin/bash

docker start/stop/restart/rm

#remove images
docker rmi

 
#to see the image metadata in json format
docker inspect <imagename:tag> 

#Add in docker file will unarhive a file if its moved
# copy will take the fill the dump it as it is


#Remove Untagged (Dangling) Images
#Add the -f flag to bypass the confirmation prompt
docker image prune -f


# The -a option removes all unused images, including both dangling and untagged images
#Add the -f flag to bypass the confirmation prompt
docker image prune -a -f


#If you want to clean up everything unused in Docker, including containers, networks, and volumes, use:
docker system prune

#For a more thorough cleanup, add the -a flag:
docker system prune -a


#Add the --volumes flag to include unused volumes:
docker system prune -a --volumes

#To remove all dangling volumes:
#Add the -f flag to bypass the confirmation prompt
docker volume prune -f

# i have ubutu image and i want to create a new image
# with dockerFile
#From ubuntu:latest
#ENTRYPOINT ["echo"]
# to build this new image with this above command i will use 
# the . is the current dict that have the dockerfile
docker build -t <give-image-name>:<give-tag> .
docker run <give-image-name>:<give-tag>

#expose in docker file is just enableing the port NOT bining the port with the host machine



# The volumes directive maps the current directory (.) on your host to /code inside the container.
# Changes in the local directory will automatically reflect inside the container.
services:
  web:
    build: .
    ports:
      - "8000:5000"
    volumes:
      - .:/code
    redis:
      image: "redis:alpine"





