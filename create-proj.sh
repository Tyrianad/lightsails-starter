#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
PROJECTS_FOLDER='htdocs/'
USER_PASS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
ROOT_PASS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)

if [ -z "$1" ]
  then
	echo -e "${RED}Please provide a folder name${NC}"
else
  echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "1.CREATING FOLDERS" &&
  echo -e "----------------------------${NC}" &&
  echo "" &&

  cd &&
	mkdir $PROJECTS_FOLDER$1 &&
	cd $PROJECTS_FOLDER$1 &&

	echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "3.COMPOSING LARAVEL PROJECT" &&
  echo -e "----------------------------${NC}" &&
  echo "" &&

	composer create-project --prefer-dist laravel/laravel . &&
  sudo chown -R bitnami:daemon storage

	echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "4.ADDING IDE_HELPER" &&
  echo -e "----------------------------${NC}" &&
  echo "" &&

	composer require --dev barryvdh/laravel-ide-helper laravel/ui

	echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "DONE" &&
  echo -e "----------------------------${NC}" &&
  echo ""

fi
