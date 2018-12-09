module ParkingLot
  module Commands
    class Status
      
      class << self
        def match(cmd)
          cmd.include? 'status'
        end    
      end

      attr_accessor :command_txt

      def initialize(command_txt)
        @command_txt = command_txt
      end

      def execute
        parking = Parking.current
        ParkingLot::Report.new(parking.slots).print
      end

    end
  end
end