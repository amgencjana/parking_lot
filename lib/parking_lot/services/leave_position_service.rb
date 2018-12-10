module ParkingLot
  
  # Services module: 
  # namespace which can encapsulate all 'logic'
  # currenly being place in Parking domain class
  module Services

    # LeavePositionService class 
    # main responsibility is to execute 
    # 
    # + leave!() to release a parking spot
    # 
    # 
    class LeavePositionService
      attr_accessor :parking, :position

      def initialize(parking, position)
        @parking       = parking 
        @position      = position
      end

      # method responsibility is to delegate to Parking  releaseing a parking slot
      #
      # return String 
      def leave!
        if parking.release(position)
          successfully_released_slot
        else
          no_car_msg
        end  
      end
     

      private 
      def no_car_msg
        "No Car on this position\n"
      end

      def successfully_released_slot
        "Slot number #{position} is free\n"
      end

    end


  end
end
