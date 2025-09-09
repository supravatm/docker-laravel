#!/usr/bin/env bash
set -o errexit

# Default values
source dev.env

echo "  Setting up Laravel project with Docker..."

# Step 1: Create Laravel project if not exists
if [ ! -d "./src" ]; then
  echo "  Run composer create project"
  docker run --rm -v $(pwd):/app composer create-project laravel/laravel src --prefer-dist
else
  echo -e "\033[31m❌ Laravel project already exists, skipping creation.\033[0m" >&2
  exit 1
fi
mkdir -p ~/.composer ~/.ssh

# Step 5: Start containers
echo "🐳 Starting Docker containers..."

docker compose --env-file dev.env -p $(grep PROJECT_NAME dev.env | cut -d '=' -f2) up -d --build

# Step 6: Configure Laravel .env
echo " Configuring Laravel environment..."

# Detect macOS vs Linux for sed -i
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS (BSD sed)
    while IFS='=' read -r key value; do
      # Skip empty lines or comments in dev.env
      [[ -z "$key" || "$key" == \#* ]] && continue

      # Check if key exists (commented or uncommented) in src/.env
      if grep -qE "^(#\s*)?$key=" src/.env; then
        # Uncomment and update the value
        sed -i '' -E "s/^[[:space:]]*#?[[:space:]]*$key=.*/$key=$value/" src/.env
      fi
    done < dev.env
fi
echo -e "\033[32m✅ Synced dev.env → Laravel .env\033[0m"


# Step 7: Run composer install & key generate
docker exec -it ${PROJECT_NAME}_app composer install
docker exec -it ${PROJECT_NAME}_app php artisan key:generate
docker exec -it ${PROJECT_NAME}_app php artisan migrate 

# Adding host entry
IP="127.0.0.1"
HOSTS_FILE="/etc/hosts"

# Check if entry already exists
if grep -q "$DOMAIN_NAME" "$HOSTS_FILE"; then
  echo -e "\033[33m⚠️  Host entry for $DOMAIN_NAME already exists\033[0m"
else
  echo "Adding host entry: $IP $DOMAIN_NAME"
  echo "$IP $DOMAIN_NAME" | sudo tee -a "$HOSTS_FILE" > /dev/null
  echo -e "\033[32m✅ Host entry added: $IP $DOMAIN_NAME\033[0m"
fi
echo "  Laravel setup complete!"
echo "  App URL: http://$DOMAIN_NAME:8080"
echo "  phpMyAdmin: http://$DOMAIN_NAME:8081"
echo "  Mailpit: http://$DOMAIN_NAME:8025"