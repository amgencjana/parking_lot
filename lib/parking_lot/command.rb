require 'pry'

module ParkingLot
  
  # consider class name to use more like Handler
  class Command
    
    attr_accessor :command

    def initialize( args ) 
    end

    def execute
      while 1 do
        cmd = STDIN.gets.chomp 

        command = ParkingLot::CommandStrategy.new(cmd)
        puts      command.execute

        break if cmd == 'exit'
      end
    end
    
  end
end
