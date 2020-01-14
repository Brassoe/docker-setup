# Setup

- Clone the [repository](https://github.com/Brassoe/docker-setup)
- Run the following commands:  

		$ cd docker-setup
		$ docker-compose up -d
		$ ./command.sh --db
		$ CREATE DATABASE intend;
		$ quit
		$ ./command.sh --reset
	
	- These commands will, in turn:
		- Change into the newly cloned directory
		- Run "docker-compose up", which starts all the containers. By default, docker-compose attaches the output of all the tailed log files to your terminal. The -d flag detaches these, so you don't end up spammed by log messages
		- Run the custom command.sh script, asking it to run a MySQL client in the database container
		- Create a database named "intend"
		- Quit out of the MySQL client (and subsequently the container)
		- Run the command.sh script, asking it to reset the database. This, in fact, does four things:
			- Wipes the database,
			- Runs all migrations (setting up the database)
			- Seeds the database (with a test user)
			- Install the modules

- Open a browser, go to [localhost](http://localhost/)

We recommend entering responsive design mode in your browser and picking a smartphone viewport, as Intend was primarily designed to run in a smartphone browser. It'll still work if you don't, but it'll look ridiculous.
