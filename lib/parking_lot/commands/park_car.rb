module ParkingLot
  module Commands
    class ParkCar

      class << self
        def match(cmd)
          cmd.include? 'park'
        end    
      end

      attr_accessor :command_txt, :command, :car, :license_plate, :color

      def initialize(command_txt)
        @command_txt     = command_txt
        @license_plate   = get_license_plate
        @color           = get_color
        @car             = get_car
      end

      def execute
        parking = Parking.current
        service = Services::ParkingService.new(parking, car)
        
        service.park_car!
      end

      private 
        def get_color
          color = command_txt.split(' ').last
        end

        def get_license_plate
          license_plate = command_txt.split(' ')[1]
        end

        def get_car
          # ::Car.new()
          OpenStruct.new(license_plate: @license_plate, color: @color)
        end

    end
  end
end