#!/bin/sh
## run with:
## /compose$ command-scripts.sh <name of docker container to get commands>
## ex) /compose$ command-scripts.sh pihole   #This command will insert the scripts into the compose/pihole folder 

cwd=$(pwd)
defd='/your/compose/root/folder'
targd=''
name=''
if [ -z "$1" ]
 then
  targd=$cwd
 else
  targd="${cwd}/${1}"
  name=$1
 fi
 
rm -f $targd/restart.sh
touch $targd/restart.sh
 {
  echo '#!/bin/sh'
  echo 'docker compose stop'
  echo 'docker compose up -d'
 } >> $targd/restart.sh

rm -f $targd/top.sh
touch $targd/top.sh
 { echo '#!/bin/sh'
   echo "cid=\$(docker ps | grep -i ${name} | awk '{print \$1}')"
   echo 'docker exec -it $cid top'
 } >> $targd/top.sh
