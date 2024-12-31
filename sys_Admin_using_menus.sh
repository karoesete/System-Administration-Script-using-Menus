#!/bin/bash 
PS3="Select Your choice: "
select ITEM in "Add User" "Delete user" "List All Processes" "Kill Process" "Install Program" "Quit"
do
if [[ $REPLY -eq 1 ]]
then
	read -p "Enter the username: " username
	output="$(grep -w $username /etc/passwd)"
	if [[ -n "$output" ]] #checking if username exists
	then
		echo "The username $username already exists."
	else
		sudo useradd -m -s /bin/bash "$username" #adding user
		if [[ $? -eq 0 ]] #checking exit status for last command
		then
			echo "The user $username was added successfully."
			tail -n 1 /etc/passwd
		else
			echo "there was an error adding the user $username."
		fi
	fi
elif [[ $REPLY -eq 2 ]]
then
	read -p "Enter the user to delete: " userdelete
	sudo userdel -r $userdelete #deleting the user
	tail -n 10 /etc/passwd
elif [[ $REPLY -eq 3 ]]
then
	echo "Listening all processes .... "
	sleep 1
	ps -ef #lising all processes
elif [[ $REPLY -eq 4 ]]
then
	read -p "Enter the process to kill: " process
	pkill $process #killing the process
elif [[ $REPLY -eq 5 ]]
then
	read -p "Enter the program to install: " app
	sudo apt update && sudo apt install $app #updating and installing the process
elif [[ $REPLY -eq 6 ]]
then
	echo "Quitting ....."
	sleep 1
	exit
else
	echo "Invalid menu selection"
fi
done
