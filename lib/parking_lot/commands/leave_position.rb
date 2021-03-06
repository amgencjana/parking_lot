module ParkingLot
  module Commands
    class LeavePosition
      
      class << self
        def match(cmd)
          cmd.include? 'leave'
        end    
      end

      attr_accessor :command_txt, :command, :position, :car

      def initialize(command_txt)
        @command_txt     = command_txt
        @position        = get_position
      end

      def execute
        parking = Parking.current
        leave_service = Services::LeavePositionService.new(parking, position)

        leave_service.leave!
      end

      private
      def get_position
        position = command_txt.split(' ').last.to_i
      end

    end
  end
end