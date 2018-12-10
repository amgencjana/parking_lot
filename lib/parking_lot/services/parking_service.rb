module ParkingLot
  
  # Services module: 
  # namespace which can encapsulate all 'logic'
  # currenly being place in Parking domain class
  module Services

    # ParkCarService class 
    # main responsibility is to execute certain acions on parking like, 
    # delegating business logic to the domain objects vide. MartinFowlerWay
    # + park_car() to allocate a car
    # 
    # 
    class ParkCarService
      attr_accessor :parking, :car

      def initialize(parking, car)
        @parking       = parking 
        @car           = car
      end

      # method responsibility is to delegate to Parking  allocating car in the available parking slot
      # it does not contains logic itself - delegates it to the Domain object
      # in this particular usage, defines output message of this operation
      #
      # return String 
      def park_car!
        return full_parking_msg if parking.parking_full?
        
        slot_number = parking.allocate(car)
        successfully_allocated_slot(slot_number)
      end
     

      private 
      def full_parking_msg
        "Sorry, parking lot is full\n"
      end

      def successfully_allocated_slot(number)
        "Allocated slot number: #{number}\n"
      end

    end


  end
end
