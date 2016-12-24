require 'cliqr'

class ComposeConsole
  def self.interface
    Cliqr.interface do
      name 'compose-console'
      description <<-EOS
This is a command line tool that allows you to easily manage your containers defined on your
docker-compose file.

This is meant for sugin docker-compose in your development environment.
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
          run "docker-compose up #{ dettach_option } #{arguments.join(' ')}"
        end
      end

      action :start do
        description 'starts the specified service'
        handler do
          `docker-compose start #{arguments.join(' ')}`
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
          run "docker-compose rm #{arguments.join(' ')}"
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
          type :boolean
        end

        handler do
          run "docker-compose logs -f #{arguments.join(' ')}"
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

  def run(command)
    begin
      system command
    rescue SystemExit, Interrupt
      puts 'exit'
    end
  end
end
