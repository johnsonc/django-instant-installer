#!/bin/bash

project_name=$1
base_dir=$2
project_dir=$base_dir'/'$project_name
modpath=$3

source $modpath'/install/utils.sh'
source bin/activate

title $yellow "6." "Install the real time modules"
echo "Installing real time package ..."
pip install -r $modpath'/install/real_time/requirements.txt'
pyscript=$modpath'/install/append_to_apps.py'
urlscript=$modpath'/install/append_to_urls.py'
settingsscript=$modpath'/install/append_to_settings.py'
urls="url(r'^centrifuge/auth/$',instant_auth,name='instant-auth'),#!#url('^instant/',include('instant.urls')),#!#url(r'^events/',include('mqueue_livefeed.urls')),"
cp -R $modpath"/templates/instant" $project_dir"/templates"
python $pyscript $project_name $base_dir instant,mqueue_livefeed,presence
echo "Settings updated"
python $urlscript $project_name $base_dir $urls instant
echo "Urls updated"

read -n 1 -p "Install the Centrifugo web sockets server (Y/n)? " answer
[ -z "$answer" ] && answer="default"
if 	[ $answer == 'default' ]
    then
		cd $base_dir
		echo "Getting the server ..."
		wget https://github.com/centrifugal/centrifugo/releases/download/v1.5.1/centrifugo-1.5.1-linux-386.zip
		echo "Installing the server ..."
		unzip centrifugo-1.5.1-linux-386.zip
		rm -f centrifugo-1.5.1-linux-386.zip
		mv centrifugo-1.5.1-linux-386 centrifugo
		echo "Generating server configuration ..."
		cd centrifugo
		./centrifugo genconfig
		pyconf=$modpath"/install/real_time/servers_config.py"
		python $pyconf $project_name $base_dir
		check "Centrifugo config generated"
fi

sleep 1
echo "Generating config for django-presence ..."
python $project_dir/manage.py installpres

ok $green "Real time package installed"
echo "Some documentation is available:
- http://django-instant.readthedocs.io/en/latest/
- http://django-presence.readthedocs.io/en/latest/"

exit 0