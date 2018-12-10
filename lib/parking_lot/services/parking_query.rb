module ParkingLot
  
  # Services module: 
  # namespace which can encapsulate all 'logic'
  # currenly being place in Parking class
  module Services

    # ParkingQuery class 
    # main responsibility is to encapsulate various types of queries / searches
    # which will be performed on the ParkingLot
    # it gives layer of abstraction which allows to change storage
    # from ($) global variable to any choosen ORM, ensuring that rest of program
    # use same interface, only implemention per data-storage will be different 
    class ParkingQuery
      attr_accessor :parking, :color, :data

      def initialize(parking, args)
        @parking = parking 
        @data    = parking.slots
        @color    = args.fetch(:color){ '' }  
      end

      def cars
        cars_by_color
      end

      def registration_number_for_colours
        cars.map(&:license_plate).join(', ')
      end

      def slots_number_for_colours
        cars.map(&:position).join(', ')
      end

      private 
        def cars_by_color
          data.compact.select{|d| d.color == color }
        end
    end


  end
end
