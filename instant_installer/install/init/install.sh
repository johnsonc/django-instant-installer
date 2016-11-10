#!/bin/bash

project_name=$1
base_dir=$2
project_dir=$base_dir'/'$project_name
mogo_dir=$base_dir
modpath=$3

source $modpath'/install/utils.sh'

# create virtualenv 
title $yellow "1." "Create virtualenv"
echo "Creating virualenv ..."
virtualenv --no-site-packages . 
source bin/activate
echo "Upgrading pip if necessary ..."
pip install --upgrade pip
ok $green "Virtualenv activated"
source bin/activate

# create project
title $yellow "2." "Install Django and create the project"
echo "Installing Django ..."
pip install 'django'
echo -e "Creating the project "$bold$project_name$normal
django-admin startproject $project_name
cd $project_name
pylib=$base_dir'/lib/python2.7/site-packages/'
ln -s $pylib "pylib"
ok $green "Project created"
sleep 1

# install Mogo files
title $yellow "3." "Install templates"
cd $modpath
echo "Installing templates ..."
mkdir $project_dir"/templates"
templatesdir=$modpath'/templates'
cp -v $templatesdir'/base.html' $project_dir"/templates"
cp -v $templatesdir'/footer.html' $project_dir"/templates"
cp -v $templatesdir'/messages_display.html' $project_dir"/templates"
echo "Creating media directories ..."
cd $project_dir
mkdir media
mkdir media/uploads
echo "Installing static files ..."
cp -Rv $modpath"/static" $project_dir
ok $green "Templates and static files installed"
sleep 1

# generate settings
title $yellow "4." "Generate settings"
settings=$project_dir'/'$project_name'/settings.py'
sp=$modpath'/install/init/create_settings.py'
dbname="Sqlite"
echo "Generating settings ..."
python  $sp $project_name $base_dir $dbname $install_mode
echo "Copying urls ..."
cd $modpath
urlspath=$modpath'/install/urls.py'
cp $urlspath $project_dir'/'$project_name
ok $green "Settings and urls generated for project "$project_name

# install basic requirements
title $yellow "5." "Install requirements"
echo "Installing requirements ..."
pip install -r $modpath'/install/init/requirements.txt'

ok $green "Django installation completed"

exit 0