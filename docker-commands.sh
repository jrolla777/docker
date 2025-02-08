#!/bin/sh

# Define variables
cwd=$(pwd)
compose_dir=~/compose
container_folder=""
container_name=""

# Determine the target directory and container name
if [ -z "$1" ]; then
  container_folder=$cwd
  container_name=$(basename "$cwd")
else
  container_folder="${cwd}/${1}"
  container_name="$1"
fi

# Ensure target directory exists
mkdir -p "$container_folder"

# Function to create scripts
create_script() {
  script_name="$1"
  content="$2"
  script_path="$container_folder/$script_name"

  rm -f "$script_path"
  touch "$script_path"
  chmod +x "$script_path"

  echo "#!/bin/sh" > "$script_path"
  echo "$content" >> "$script_path"
}

# Restart script
create_script "restart.sh" "docker compose stop && docker compose up -d"

# Update container script
create_script "update-container.sh" "docker compose stop && docker compose pull && docker compose up -d"

# Rebuild container script
create_script "rebuild-container.sh" "docker compose down && docker compose pull && docker compose up -d"

# Top script (view running processes)
create_script "top.sh" "cid=\$(docker ps | grep -i $container_name | awk '{print \$1}')\ndocker exec -it \$cid top"

# Exec script with flexible container name
create_script "exec.sh" "cid=\$(docker ps | grep -i $container_name | awk '{print \$1}')\ndocker exec -it \$cid sh"

echo "Scripts have been created in $container_folder"
