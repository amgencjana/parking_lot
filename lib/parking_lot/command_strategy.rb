require_relative 'commands/create_parking_lot_command'
require_relative 'commands/park_car'
require_relative 'commands/leave_position'
require_relative 'commands/status'
require_relative 'commands/registration_number_for_colour'
require_relative 'commands/slots_number_for_colour'
require_relative 'commands/slot_number_for_registration'


module ParkingLot

  # CommandStrategy
  # 
  # class responsible for orchestrating and recognising to which specific class delegat execution of command 
  # usage of the Open Close principle allows to make in the easy way extend number of commands 
  # and ease of handling different variants of existing ones 
  #
  class CommandStrategy
    AVAILABLE_COMMANDS = [
      Commands::CreateParkingLotCommand, 
      Commands::ParkCar, 
      Commands::LeavePosition, 
      Commands::Status,
      Commands::RegistrationNumberForColour,
      Commands::SlotsNumberForColour,
      Commands::SlotNumberForRegistration 
    ]

    attr_accessor :command_txt, :commands

    def initialize(command_txt)     
      @command_txt = command_txt      
      @commands = AVAILABLE_COMMANDS
    end

    def command
      command_klass = find_command_based_on_pattern

      command_klass.new(command_txt)
    end

    private
      def find_command_based_on_pattern
        command_klass = commands.select{|c| c.match(command_txt)}.first
      end
  end
end