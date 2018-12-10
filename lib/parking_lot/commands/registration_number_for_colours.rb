module ParkingLot
  module Commands
    class RegistrationNumberForColours

      class << self
        def match(cmd)
          cmd.include? 'registration_numbers_for_cars_with_colour'
        end    
      end

      attr_accessor :command_txt, :command, :color

      def initialize(command_txt)
        @command_txt     = command_txt
        @color           = get_color
      end

      def execute
        parking = Parking.current

        query = ParkingLot::Services::ParkingQuery.new(parking, color: color)
        query.registration_number_for_colours
      end

      private 
        def get_color
          color = command_txt.split(' ').last
        end

    end
  end
end