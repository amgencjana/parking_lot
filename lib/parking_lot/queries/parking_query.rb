module ParkingLot
  
  # Query module: 
  # namespace which can encapsulate all 'queries'
  # related to the Parking data
  module Queries

    # ParkingQuery class 
    # main responsibility is to encapsulate various types of queries / searches
    # which will be performed on the ParkingLot
    # it gives layer of abstraction which allows to change storage
    # from ($) global variable to any choosen ORM, ensuring that rest of program
    # use same interface, only implemention per data-storage will be different 
    class ParkingQuery
      attr_accessor :parking, :color, :data, :license_plate

      def initialize(parking, args)
        @parking       = parking 
        @data          = parking.slots
        @color         = args.fetch(:color){ '' }  
        @license_plate = args.fetch(:license_plate){ '' }
      end


      # there is a huge potential to extract namespace Queries 
      # and to have 2 dediated Query Objects one for each type
      def cars
        return cars_by_license_plate unless @license_plate.empty?
        cars_by_color
      end

      def registration_number_for_colours
        cars.map(&:license_plate).join(', ')
      end

      def slots_number_for_colours
        cars.map(&:position).join(', ')
      end

      # expect to get only one car 
      # to keep same interface we are passing
      # an Array with one element
      def slot_number_by_license_plate
        return 'Not found' if cars.empty?
        cars.map(&:position).join('')
      end

      private 
        def cars_by_color
          return data if @color.empty?
          data.compact.select{|slot| slot.color == color }
        end

        def cars_by_license_plate
          return data if @license_plate.empty?
          data.compact.select{|slot| slot.license_plate == license_plate }
        end
    end


  end
end
