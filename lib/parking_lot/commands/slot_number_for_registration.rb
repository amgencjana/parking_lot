module ParkingLot
  module Commands
    class SlotNumberForRegistration

     class << self
        def match(cmd)
          cmd.include? 'slot_number_for_registration_number'
        end    
      end

      attr_accessor :command_txt, :command, :license_plate

      def initialize(command_txt)
        @command_txt     = command_txt
        @license_plate   = get_license_plate
      end

      def execute
        parking = Parking.current

        query = ParkingLot::Queries::ParkingQuery.new(parking, license_plate: license_plate)
        query.slot_number_by_license_plate
      end

      private 
        def get_license_plate
          color = command_txt.split(' ').last
        end

    end
  end
end