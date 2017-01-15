# compose-console

WIP

"compose-console" is a wrapper CLI on top of docker-compose for simplifing the syntax of the most common
docker-compose commands used during projects development using docker environment. It's use is meant
for development environments.

### Install

 - Make sure you have ruby installed in your system
 - Clone the repository
 - Run `bundle install --without development` for installing the required dependencies
 - Add `bin/compose-console` to your PATH
 - You are ready to go!!

### Use

In the folder of your project at the same level as your `docker-compose.yml` file, execute:

~~~
compose-console shell
~~~

Then, you will be inside an interactive console where you can execute all the commands defined in
compose-console.

For more information, try to run `help`

### Commands implemented

Run `compose-console help` for a detailed list of the commands and the options
