#!/bin/bash
# Stop script when any of the commands fail
set -e

SUCCESS_COLOR='\033[1;32m'
ORANGE_COLOR='\033[0;33m'
NO_COLOR='\033[0m'
BOLD_TEXT='\033[1m'

function to_lower_case() {
  echo "$1" | tr '[:upper:]' '[:lower:]'
}

# $1 = Pattern , $2 Filepath
function set_env() {
  # For MacOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    find $2 -type f -exec sed -i '' -e "$1" {} \;
  else # For Other OS
    sed -i "$1" $2
  fi
}

if ! docker info > /dev/null 2>&1; then
  echo -e "${ORANGE_COLOR}[WARNING]${NO_COLOR} This script requires ${BOLD_TEXT}Docker Desktop${NO_COLOR} and it isn't running. Please start ${BOLD_TEXT}Docker Desktop${NO_COLOR} and try again!"
  exit 1
fi

# Docker Build Variables
ENVIRONMENT=
PROJECT_NAME=
MYSQL_ROOT_PASSWORD=
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
APP_DOMAIN=localhost

echo "Environment:"
PS3="Select your Environment [Choose a number]: "
options=("Development" "Staging" "Production")
select opt in "${options[@]}" "Quit"; do 
    case "$REPLY" in
        1) ENVIRONMENT=development; break;;
        2) ENVIRONMENT=staging; break;;
        3) ENVIRONMENT=production; break;;
        $((${#options[@]}+1))) echo "Goodbye!"; break;;
        *) echo "Invalid option. Try another one.";continue;;
    esac
done

# TODO: Validate Domain no special character and spaces except underscore
while [[ $PROJECT_NAME = "" && $PROJECT_NAME != ^\(?![0-9._]\)\(?!.*[0-9._]$\)\(?!.*\d_\)\(?!.*_\d\)[a-zA-Z0-9_]+$ ]]; do
    read -p 'Project Name: ' PROJECT_NAME
done

# remove special characters and spaces and convert string to lowercase
PROJECT_NAME=$(echo ${PROJECT_NAME//[^a-zA-Z ]/""})
PROJECT_NAME=$(echo ${PROJECT_NAME//[ ]/"_"})
PROJECT_NAME=$(to_lower_case $PROJECT_NAME)

# Generate MySQL Credentials
MYSQL_DATABASE=$(to_lower_case $PROJECT_NAME)
MYSQL_USER=$(to_lower_case $PROJECT_NAME)
MYSQL_PASSWORD=$(LC_ALL=C < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16})

if [[ $ENVIRONMENT != "development" ]]; then
  # Reset App domain
  APP_DOMAIN=

  while [[ $APP_DOMAIN = "" ]]; do
    read -p 'Application Domain Name(e.g domain.com): ' APP_DOMAIN
    echo "(For development environment, make sure to add the Domain Name in your machine host file.)"
  done
fi

read -p "Proceed to Build? (y/n): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    # Update Docker .env
    echo -n "Setting up Docker environment variables ... "
    cp .env.example .env
    set_env "s/ENVIRONMENT=/ENVIRONMENT=$ENVIRONMENT/g" .env;
    set_env "s/PROJECT_NAME=/PROJECT_NAME=$PROJECT_NAME/g" .env;
    set_env "s/MYSQL_ROOT_PASSWORD=/MYSQL_ROOT_PASSWORD=$(LC_ALL=C < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16})/g"  .env;
    set_env "s/MYSQL_DATABASE=/MYSQL_DATABASE=$MYSQL_DATABASE/g"  .env;
    set_env "s/MYSQL_USER=/MYSQL_USER=$MYSQL_USER/g"  .env;
    set_env "s/MYSQL_PASSWORD=/MYSQL_PASSWORD=$MYSQL_PASSWORD/g"  .env;

    set_env "s/APP_DOMAIN=/APP_DOMAIN=$APP_DOMAIN/g" .env;

    if [[ $ENVIRONMENT == "development" ]]; then
        set_env "s/ENABLE_XDEBUG=0/ENABLE_XDEBUG=1/g" .env;
    fi

    echo -e "${SUCCESS_COLOR}done${NO_COLOR}"

    # Update Laravel .env
    echo -n "Setting up Laravel environment variables ... "
    cp src/backend/.env.example src/backend/.env
    set_env "s/APP_NAME=Laravel/APP_NAME=$PROJECT_NAME/g" src/backend/.env;
    set_env "s/APP_ENV=local/APP_ENV=$ENVIRONMENT/g" src/backend/.env;

    if [[ $ENVIRONMENT != "development" ]]; then
        set_env "s/APP_DEBUG=true/APP_DEBUG=false/g" .env;
    fi

    echo -e "${SUCCESS_COLOR}done${NO_COLOR}"

    set_env "s/DB_DATABASE=/DB_DATABASE=$MYSQL_DATABASE/g" src/backend/.env;
    set_env "s/DB_USERNAME=/DB_USERNAME=$MYSQL_USER/g" src/backend/.env;
    set_env "s/DB_PASSWORD=/DB_PASSWORD=$MYSQL_PASSWORD/g" src/backend/.env;
    set_env "s/CACHE_DRIVER=file/CACHE_DRIVER=redis/g" src/backend/.env;
    set_env "s/QUEUE_CONNECTION=sync/QUEUE_CONNECTION=redis/g" src/backend/.env;

    if [[ $ENVIRONMENT == "development" ]]; then
        set_env "s/APP_URL=http:\/\/localhost/APP_URL=$APP_DOMAIN:3000/g" .env;
    else
        set_env "s/APP_URL=http:\/\/localhost/APP_URL=http:\/\/$APP_DOMAIN/g" src/backend/.env;
    fi

    # Update NuxtJS .env
    echo -n "Setting up NuxtJS environment variables ... "
    cp src/frontend/.env.example src/frontend/.env
    set_env "s/NUXT_ENV_SITE_TITLE=\"NUXTJS Base\"/NUXT_ENV_SITE_TITLE=$PROJECT_NAME/g" src/frontend/.env;
    set_env "s/NUXT_ENV_API_URL=/NUXT_ENV_API_URL=http:\/\/$APP_DOMAIN\/api\/v1/g" src/frontend/.env;

    if [[ $ENVIRONMENT == "development" ]]; then
        set_env "s/NUXT_ENV_SITE_URL=/NUXT_ENV_SITE_URL=http:\/\/$APP_DOMAIN:3000/g" src/frontend/.env;
    else
        set_env "s/NUXT_ENV_SITE_URL=/NUXT_ENV_SITE_URL=http:\/\/$APP_DOMAIN/g" src/frontend/.env;
    fi

    echo -e "${SUCCESS_COLOR}done${NO_COLOR}"

    if [[ $ENVIRONMENT == "development" ]]; then
      DOCKER_COMPOSE_COMMAND="composer install && php artisan key:generate && php artisan migrate:fresh --seed"
      DOCKER_COMPOSE_FILE="docker-compose.yml"
    else
      DOCKER_COMPOSE_COMMAND="composer install --optimize-autoloader --no-dev && php artisan key:generate && php artisan migrate:fresh --seed"
      DOCKER_COMPOSE_FILE="production.docker-compose.yml"
    fi

    # Build Docker Containers
    docker compose -f $DOCKER_COMPOSE_FILE build --no-cache

    # Install PHP Laravel Packages and migrate database with seeders
    docker compose run --rm php bash -c "
      while ! nc -z mysql 3306; do
        echo 'Waiting for MySQL to be available...';
        sleep 2;
      done;
	  echo 'MySQL is UP!';
      $DOCKER_COMPOSE_COMMAND && php artisan storage:link"

    # Setup Laravel Passport
    docker compose run --rm php php artisan passport:install --force --no-interaction >> output.txt
    docker compose run --rm php bash -c "chmod og+r /var/www/backend/storage/*.key"
    # Update Laravel & NuxtJS environment variables
    CLIENT_ID=$(awk '/Client ID/ {client=$NF} END {print client}' output.txt)
    CLIENT_SECRET=$(awk '/Client secret/ {client=$NF} END {print client}' output.txt)
    rm output.txt
    CLIENT_ID="$(echo ${CLIENT_ID/Client ID:/""} | tr -d '[:space:]' | perl -pe 's/\x1b\[[0-9;]*[mG]//g')"
    CLIENT_SECRET="$(echo ${CLIENT_SECRET/Client secret:/""} | tr -d '[:space:]' | perl -pe 's/\x1b\[[0-9;]*[mG]//g')"
    set_env "s/API_CLIENT_ID=/API_CLIENT_ID=$CLIENT_ID/g" src/backend/.env;
    set_env "s/API_CLIENT_SECRET=/API_CLIENT_SECRET=$CLIENT_SECRET/g" src/backend/.env;
    set_env "s/NUXT_ENV_CLIENT_ID=/NUXT_ENV_CLIENT_ID=$CLIENT_ID/g" src/frontend/.env;
    set_env "s/NUXT_ENV_CLIENT_SECRET=/NUXT_ENV_CLIENT_SECRET=$CLIENT_SECRET/g" src/frontend/.env;

    if [[ $ENVIRONMENT != "development" ]]; then
      # Build NuxtJS for Production Environment
      docker compose run --rm node npm run build
    fi

    # Start the docker containers
    COMPOSE_HTTP_TIMEOUT=900 docker compose -f $DOCKER_COMPOSE_FILE up -d

    SITE_URL="http://${APP_DOMAIN}"

    if [[ $ENVIRONMENT == "development" ]]; then
      SITE_URL="http://${APP_DOMAIN}:3000"
    fi

    # Display the results
    echo -e "\n\n${SUCCESS_COLOR}Project Setup Completed${NO_COLOR}"
    echo -e "You can now access the app by clicking this link ${SUCCESS_COLOR}${SITE_URL}${NO_COLOR}"
fi
