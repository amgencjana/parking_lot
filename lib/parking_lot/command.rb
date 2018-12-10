require 'pry'

module ParkingLot
  
  # consider class name to use more like Handler
  class Command
    
    attr_accessor :command

    def initialize( args ) 
      # handle openning and parsing File as an argument
    end

    def execute
      while 1 do
        cmd = STDIN.gets.chomp 

        puts ParkingLot::CommandStrategy.new(cmd).command.execute
              
        break if cmd == 'exit'
      end
    end
    
  end
end
