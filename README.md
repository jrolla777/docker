## Helpful little shell scripts for docker compose commands to restart, update, exec, etc.




### <ins>**Usage:**</ins>
Meant to sit in your `compose` folder. Mine's located at `/home/user/compose`, or simply `~/compose`. Inside the `compose`, people usually keep folders of their docker containers (at least thats how I do it). When running the script, add the docker container name (main app if it's a stack) as a single variable after `$ sh docker-commands.sh`. The script will put the commands in the container's folder. You would also copy the `docker-commands.sh` script to the container folder and run it without a variable afterwards and it will place the new scripts in the current working directory. 

 
#### Example:
If you were to run the command `$ sh docker-commands.sh bazarr` from your `~/compose`, you'd get:

![image](https://github.com/user-attachments/assets/72960efb-f85e-4654-8d97-8c4a648d03a7)

