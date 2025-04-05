#!/bin/bash   
#------------------------------
# This bash script resives random number of arguments
# First argument is a port number 
# Other are people names
# Bash script has to be possible run python script with given arguments
# Python script has to say hello everyone and generate index.html with a meme picture and greetings.
# Bash script must create docker image with nginx and index.html as start page for nginx
# Then bash script must run docker container in interactive mode on given port or use port 8080 as default
#--------------------------------
array=($@)     # array that contain all given arguments

if ! [[ $1 =~ ^[0-9]+$ ]];    # using =~ to check does script get port number from user 
   then echo "error: Not a number"
   python3 script.py ${array[@]}  # python script resive people names
   port=8080  #  default port number
   else 
   python3 script.py ${array[@]:1} # python script resive people names without port number
   port=$1   # get port number from  bash script argument
fi

#--------Generate Dockerfile file using cat command----------
cat > Dockerfile << EOF
FROM nginx:1.24.0-alpine   
COPY index.html /usr/share/nginx/html   
COPY image.png /usr/share/nginx/html
EXPOSE $port 
CMD ["nginx", "-g", "daemon off;"] 
EOF



docker build . -t mynginx  # build docker image using generated Dockerfile
docker run -i --name runnginx -p $port:80 mynginx #running container from image  where -i interactive mode, 
# runnginx - name of container, port - port setted by user or default 8080, mynginx - generated docker image 

