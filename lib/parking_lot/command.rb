require 'pry'

module ParkingLot
  
  # consider class name to use more like Handler
  # class CommandHandler - receives either array of commands or waits for an input
  class Command
    
    attr_accessor :command

    attr_accessor :read_commands 

    def initialize( file_name ) 
      # handle openning and parsing File as an argument
      @read_commands = []

      if file_name
        file = File.read(file_name)
        @read_commands = file.lines if file
      end
    end

    def execute
      unless @read_commands.empty?
        execute_file_input
      else
        execute_console_input
      end
    end
    
    private 

    def execute_file_input
      @read_commands.each do |cmd|
        puts ParkingLot::CommandStrategy.new(cmd).command.execute
      end 
        
    end

    def execute_console_input
      while 1 do
        cmd = STDIN.gets.chomp 

        puts ParkingLot::CommandStrategy.new(cmd).command.execute
              
        break if cmd == 'exit'
      end
    end

  end
end
