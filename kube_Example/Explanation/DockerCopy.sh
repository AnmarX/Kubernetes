#copy file from local machine to docker container
docker cp <local-file-path> <container-name>:<container-destination-path>

#example
docker cp ./example.txt my-container:/app/example.txt

