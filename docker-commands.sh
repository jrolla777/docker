#!/bin/sh
cwd=$(pwd)
defd='~/compose/'
targd=''
name=''
if [ -z "$1" ]
 then
  targd=$cwd

 else
  targd="${cwd}/${1}"
  mkdir -p $targd
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
{
        echo '#!/bin/sh'
       # echo 'cid=$(docker ps | grep -i $name | awk '{print $1}')'
        echo "cid=\$(docker ps | grep -i $name | awk '{print \$1}')"
        echo 'docker exec -it $cid top'

} >> $targd/top.sh

rm -f $targd/update-container.sh
touch $targd/update-container.sh
{
        echo '#!/bin/sh'
        echo '#docker compose stop'
        echo 'docker compose down'
        echo 'docker compose pull'
        echo 'docker compose up -d'

} >> $targd/update-container.sh

## see conainer processes
rm -f $targd/top.sh
touch $targd/top.sh
 { echo '#!/bin/sh'
   echo "cid=\$(docker ps | grep -i ${name} | awk '{print \$1}')"
   echo 'docker exec -it $cid top'
 } >> $targd/top.sh
