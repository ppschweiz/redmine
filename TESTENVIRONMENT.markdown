# Setupguide to install test environment

This guide asumes that you are using vagrant and that you are familiar in its usage.
In this repository you can find a Vagrantfile to fire up vm. The folowing explanations
describe the steps you to be taken after the vm is up and running.

## Configure your test vm

Ruby and Rubygems are allready installed on the base box defined in the Vagrantfile.
You can test this with:

	$ ruby -v
	$ gem -v

Sped up rubygem installations and keep the environment clean and small.

	$ sudo sh -c 'echo "gem: --no-ri --no-rdoc" > /etc/gemrc'

### Install all required packages.

	$ sudo apt-get update
	$ sudo apt-get install libmagickwand-dev imagemagick libsqlite3-dev texlive-full zip unzip gitosis
	$ echo "Take a long long brake"
	$ sudo gem install rails -v "2.3.14"
	$ sudo gem install sqlite3 RedCloth inifile net-ssh lockfile etherpad-lite
	
### Configure LaTex

	$ cd /etc/texmf/tex/latex/
	$ sudo git clone http://projects.piratenpartei.ch/git/mmd.git pirateparty
	$ sudo mktexlsr
	$ cd /usr/share/fonts/truetype
	$ sudo wget http://www.fontsquirrel.com/fonts/download/Aller
	$ sudo mkdir aller
	$ cd aller
	$ sudo unzip ../Aller
	$ sudo fc-cache -f -v

### Configure gitosis

	$ cd
	$ ssh-keygen
	$ sudo -s
	$ su gitosis
	$ bash
	$ gitosis-init < /home/vagrant/.ssh/id_rsa.pub
	$ exit
	$ exit
	$ exit

### Prepare Redmine.

 	$ cd /vagrant
	$ cp config/database.yml.template config/database.yml
	$ export RAILS_ENV=stage
	$ rake generate_session_store
	$ rake db:migrate
	$ rake redmine:load_default_data
	$ rake db:migrate:plugins

### Run Redmine.

	$ cd /vagrant && export RAILS_ENV=stage && ruby script/server

### Working with Redmine.

Afther this you can acces Redmin with a browser on your host systems by call the url
localhost:3000.

### Configure Redmine

@http://localhost:3000/settings/plugin/redmine_gitosis@

Gitosis URL:
	~ gitosis@localhost:gitosis-admin.git
Gitosis identity file:
	~ /home/vagrant/.ssh/id_rsa
Base path
	~ /srv/gitosis/repositories
Developer base URL:
	~ gitosis@localhost:3000

## Todo

Provide a Chef cookbook to automate the above steps.
