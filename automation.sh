#!/bin/bash
#This script is only a example creating a user and password - Based into Debian/Ubuntu servers
#In This example you will user a password for user admin to access the server, we  automate the login with pem key on aws or public keys.

#Available servers
Server[0]='IP FROM YOUR SERVER' #This is a array to do the same in many servers.

#asking for some information to the user
echo This is a batch to create or remove a user into our servers, please select your option:
echo 1 - Create a new user
echo 2 - Remove a existing user
read option

#creating user and setting password
if [ $option = "1" ]; then
	echo Please, input the username to create:
	read username
	echo Please, input the password:
	read password
	for each in "${Server[@]}"
	do
		:
		##Create user
		ssh admin@$each 'sudo useradd -m -s /bin/bash '$username';'
		##Set password
		ssh admin@$each 'echo -e "'$password"\n"$password'" | (sudo passwd '$username');'
	done
fi

#deleting user - we ask 2 times username to make sure they want to delete
if [ $option == "2" ]; then
	echo Please, provide the username to delete:
	read username1
	echo ---Take Care -- Take Care --- 
	echo Please, confirme the username to delete, you cant rollback this action:
	read username2
	if [ $username1 == $username2 ]; then
		for each in "${Server[@]}"
		do
			:
			##Delete user
			ssh admin@$each 'sudo userdel -f -r '$username1';'
		done
	fi
fi

#Return to bash
echo Done - Have a good day.