require 'cliqr'

class ComposeConsole
  def self.interface
    Cliqr.interface do
      name 'compose-console'
      description <<-EOS
This is a command line tool that allows you to easily manage your containers defined on your
docker-compose file.

This is meant for managing docker-compose in your development environment.
EOS
      version '0.0.1'
      arguments :disable

      action :up do
        description 'initialize the services'

        option :attach do
          short 'a'
          description 'Attach to the started containers'
          type :boolean
        end

        handler do
          dettach_option = attach.value ? '' : '-d'
          ComposeConsole.run "docker-compose up #{ dettach_option } #{arguments.join(' ')}"
        end
      end

      action :start do
        description 'starts the specified service'
        handler do
          `docker-compose start #{arguments.join(' ')}`
        end
      end

      action :restart do
        description 'restarts the specified service'
        handler do
          `docker-compose restart #{arguments.join(' ')}`
        end
      end

      action :stop do
        description 'stops the specified service'
        handler do
          `docker-compose stop #{arguments.join(' ')}`
        end
      end

      action :rm do
        description 'removes the specified service'
        handler do
          ComposeConsole.run "docker-compose rm #{arguments.join(' ')}"
        end
      end

      action :down do
        description 'clear the containers created'
        handler do
          `docker-compose down`
        end
      end

      action :logs do
        description 'show logs from container'

        option :lines do
          short 'l'
          description 'Number of lines to show from the logs'
          type :numeric
        end

        handler do
          ComposeConsole.run "docker-compose logs -f #{"--tail #{lines}" unless lines.value == 0 } #{arguments.join(' ')}"
        end
      end

      action :exec do
        description 'execute command in container'

        option :service do
          short 's'
          description 'Service where the command will be executed. First service by default'
          type :any
        end

        handler do
          service_name = service.value
          if service_name.nil?
            first_container = `docker-compose ps`.split("\n")[2]
            service = /\w+_(\w+)_\d/.match(first_container)[1]
          else
            service = service_name
          end
          ComposeConsole.run("docker-compose exec #{service} #{arguments.join(' ')}")
        end
      end

      action :ps do
        description 'shows current state of the containers'
        handler do
          puts `docker-compose ps`
        end
      end

      action :test do
        description 'for testing'
        handler do
          puts arguments.join(' ')
        end
      end
    end
  end

  private

  def self.run(command)
    begin
      system command
    rescue SystemExit, Interrupt
      puts 'exit'
    end
  end
end
