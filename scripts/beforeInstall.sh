#!/bin/bash
DATE=$(date +"%Y%m%d_%H%M%S")
APP=editor

if [ ! -d "/var/www/release" ]; then
    echo "Create release directory"
    mkdir /var/www/release
fi

if [ ! -d "/var/www/release/$APP" ]; then
    echo "Create project root directory"
    mkdir /var/www/release/$APP
fi

if [ ! -d "/var/www/release/$APP/new" ]; then
    echo "Create new project directory"
    mkdir /var/www/release/$APP/new
fi