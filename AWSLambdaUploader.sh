#!/bin/bash

#Run this script in a folder 1 level above of the folder that contains
#the AWS Deployment (script and dependencies, credential files, etc)
#If you have a credentials file that you want to leave out of Github,
#you should leave it 1 level above the Deployment folder
#Uploads changes to github and zip, creates deployment Zip file and uploads to AWS

#Change name of this folder name
cd NameOfFolderContainingAWSDeployment
rm AWSDeployment.zip
zip -r AWSDeployment.zip .
mv AWSDeployment.zip ..

git init

git config user.name "YourUserName"
git config user.email "Your@GithubEmail.com"
git add .

#If you have a file containing credentials that you wish to leave out of git,
#Uncomment this line and put name of the file
#git rm creds.json

IFS= read -r -p "Enter commit message: " input
# read varname
# $echo $varname
git commit -m "$input"

git push

cd ..

#If you have a credentials file, uncomment this line
#zip -ur AWSDeployment.zip creds.json
aws lambda update-function-code --function-name YourLambdaNameInAws --zip-file fileb://AWSDeployment.zip
