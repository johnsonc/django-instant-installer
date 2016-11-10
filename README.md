# Django instant installer

Installer and demo for [Django Instant](https://github.com/synw/django-instant).

This will install Django and:

- [Centrifugo](https://github.com/centrifugal/centrifugo): the websockets server.
- [Django Instant](https://github.com/synw/django-instant): the Centrifugo <-> Django layer
- [Django Mqueue Livefeed](https://github.com/synw/django-mqueue-livefeed): realtime application events and logs
- [Django Presence](https://github.com/synw/django-presence): user presence notification widget

## Install

Note: do not set a virtualenv, the installer will do it for you.

Clone and cd into the directory then:

  ```bash
python instant_installer
  ```

## Demo

To install the demo:

  ```bash
python instant_installer -d
  ```

To get a full demo just say yes to everything and open your browser.

## Run the servers

Note: the installer has an option to start the servers at the end of the process. When you Ctrl+c to stop you have to
shutdown centpres manualy: `killall centpres`

To run the servers manualy cd to the dir where you installed and:

  ```bash
cd centrifugo
./centrifugo --port=8001 --config=config.json
# go into another terminal then:
cd ../my_project_dir/
./centpres &
python manage.py runserver
  ```