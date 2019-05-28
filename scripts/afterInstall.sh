#!/bin/bash
DATE=$(date +"%Y%m%d_%H%M%S")

APP=codebuild-test

RELEASE_APP_FOLDER=/var/www/release/$APP
NEW_FOLDER=$RELEASE_APP_FOLDER/new

APP_FOLDER=/var/www/html/$APP
LOGS_FOLDER=/var/www/html/logs

# DEPLOYMENT_GROUP_NAME from codedeploy 
# if [ "$DEPLOYMENT_GROUP_NAME" == "RTL-DeployGroup-Editor-Dev" ]; then
#     echo "copy .env.dev to .env"
#     mv $NEW_FOLDER/.env.dev $NEW_FOLDER/.env
#     rm .env.local
#     rm .env.prod
# fi
# if [ "$DEPLOYMENT_GROUP_NAME" == "RTL-DeployGroup-API-Prod" ]; then
#     echo "copy .env.prod to .env"
#     mv $NEW_FOLDER/.env.prod $NEW_FOLDER/.env
#     rm .env.local
#     rm .env.dev
# fi

# echo "Install dependencies by composer"
# cd $NEW_FOLDER
# composer install

# echo "Grant permissions"
# chmod -R 777 $NEW_FOLDER/storage
# chmod -R 777 $NEW_FOLDER/bootstrap/cache

echo "Change folder name"
mv $NEW_FOLDER $RELEASE_APP_FOLDER/$DATE

echo "Update symlink"
echo "Remove exists app symlink";
sudo rm -rf $APP_FOLDER

echo "Create new app symlink";
ln -s $RELEASE_APP_FOLDER/$DATE $APP_FOLDER

# if [ -d "$RELEASE_APP_FOLDER/$DATE/storage/logs" ]; then
#     echo "Remove log dir in project folder"
#     sudo rm -rf $RELEASE_APP_FOLDER/$DATE/storage/logs
# fi

# if [ ! -d "$LOGS_FOLDER"]; then
#     echo "Create logs folder for Project"
#     mkdir $LOGS_FOLDER
# fi

# if [ ! -d "$LOGS_FOLDER/$APP" ]; then
#     echo "Create logs folder for $APP"
#     mkdir $LOGS_FOLDER/$APP
# fi

# echo "Update log symbolic link"
# ln -s $LOGS_FOLDER/$APP $APP_FOLDER/storage/logs

echo "Change owner"
chown -R ubuntu:ubuntu $NEW_FOLDER $RELEASE_APP_FOLDER/$DATE

echo "Remove old released"
sudo rm -rf `ls -dt $RELEASE_APP_FOLDER/* | tail -n +6`;

echo "Flush redis"
redis-cli flushall