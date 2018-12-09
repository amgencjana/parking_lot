module ParkingLot
  module Commands
    # CreateParkingLotCommand
    # 
    #   class responsible for knowing how to parse given 'text command' 
    #   and distribute its part to the attributes dedicated for this particular type of command
    #   and further passing it further to the Domain Object
    #
    class CreateParkingLotCommand
      
      class << self
        def match(cmd)
          cmd.include? 'create_parking_lot'
        end    
      end

      attr_accessor :command_txt, :command, :number_of_slots
      def initialize(command_txt)
        @command_txt     = command_txt
        @number_of_slots = get_number_of_slots
      end

      def execute
        Parking.new(number_of_slots).save
        "Created a parking lot with #{number_of_slots} slots\n"
      end



      private 
        def get_last_argument
          slots_number = command_txt.split(' ').last
          raise InvalidArgumentError unless slots_number.to_i > 0
          slots_number.to_i
        end

        def get_number_of_slots
          raise InvalidInputError unless valid_input?
          slots_number = get_last_argument
          slots_number.to_i
        end

        def valid_input?
          command_txt.include?(' ')
        end

    end

    class InvalidInputError < StandardError 
      def initialize
        super('Input must include space before argument')
      end
    end

    class InvalidArgumentError < StandardError 
      def initialize
        super('Argument must be type of Integer')
      end
    end
  end
end