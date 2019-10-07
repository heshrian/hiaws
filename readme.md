#
5 easy steps on how to upload your docker image to AWS

Step 1 - create/ use an application that writes out 'Hello World'


Step 2 - Dockerise the application: - creat a Dockerfile in the app's root directory    
FROM node:alpine --> alpine for small apps ( < 5mb)  
WORKDIR /usr/src/app --> create app directory  
COPY package*.json ./ --> install app dependencies  
RUN npm install --> all dependencies will be downloaded in the Docker image  
COPY . . --> boundle app source (from root to WORKDIR in docker image)  
EXPOSE 3005 --> CMD ["npm", "start"] --> command to run ( npm start = node app.js in cli)  


Step 3  
- Create Docker image:  
- docker build -t NAMEOFTHEIMAGE . --> build the image( docker image ls/ docker images will show NAMEOFTHEIMAGE)  
- you can check if the images works by typing to the cli 'docker run -d -p PORT on YOUR computer:EXPOSED port(from Dockerfile) NAMEOFTHEIMAGE --> go to localhost:PORT on YOUR computer and see the magic!


Step 4  
- Deploy to AWS EB:  
- Open terminal in app's root directory, type 'eb init'  
- You'll need to give your IAM credentials ( acces key and secret access key)  
- Then you'll need to set up informations about the app (name, where to upload, etc)  
- EB CLI will detect docker and ask about it, just say 'yes'  
- After the init command is finished a new .elasticbeanstalk file is created in your app's root dir with all the config that you had set up with the init command(also added to .gitignore)  
- type 'eb create' to CLI and wait until the app is created. Check AWS for status.  
- If the health is green --> your app is created and uploaded!  
- Go to the URL: your environment name. chosen region. elasticbeanstalk.com
 
Step 5 Profit
#
---
Deploying to AWS  
  
Create a Dockerrun.aws.json file -> "AWSEBDockerrunVersion": "1", 1 for single image 2 for docker-compose  
Name for the image -> docker image's name on dockerhub  
  
Create a Jenkinsfile with the docker hub credentials as seen in this file  
(https://medium.com/@gustavo.guss/jenkins-building-docker-image-and-sending-to-registry-64b84ea45ee9)  
My only difference is that I didn't use any :$BUILD_NUMBER -> server was misbehaving!!  
Added deploy to AWS  stage to Jenkinsfile -> withAWS(region: your-chosen-region, credentials: create a new credential with your aws acces ID and secret access key)  and run a script NAMETHESCRIPT.sh
  
Create a .sh file -> aws s3 cp ./Dockerrun.aws.json \ -> copy your file to   
s3://elasticbeanstalk-your-chosen-region-s3name/url(long number)/folder-you-want-your-file-in/Dockerrun.aws.json  
Follow this deploy.sh, the only thing needs to be changed is  
-source-bundle S3Bucket="elasticbeanstalk-your-chosen-region-s3name/url(long number)"  
-S3Key="/folder-you-want-your-file-in/Dockerrun.aws.json"  

Profit again! 


 



