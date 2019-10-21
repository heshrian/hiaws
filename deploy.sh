aws s3 cp ./Dockerrun.aws.json \
  s3://elasticbeanstalk-eu-west-2-124429370407/hiDockerAgain/$BUILD_ID/Dockerrun.aws.json

aws elasticbeanstalk create-application-version \
  --application-name "hiDockerAgain" \
  --version-label hiDockerAgain-$BUILD_ID \
  --source-bundle S3Bucket="elasticbeanstalk-eu-west-2-124429370407",S3Key="hiDockerAgain/$BUILD_ID/Dockerrun.aws.json" \
  --auto-create-application

  aws elasticbeanstalk update-environment \
  --application-name "hiDockerAgain" \
  --environment-name "hiDockerAgain-dev" \
  --version-label hiDockerAgain-$BUILD_ID \
  