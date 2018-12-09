require_relative 'parking_lot/command'
require_relative 'parking_lot/command_strategy'

require 'ostruct'

module ParkingLot

  class Parking
    attr_accessor :number_of_slots, :slots

    def initialize(number_of_slots)
      @number_of_slots = number_of_slots
      @slots           = Array.new(@number_of_slots)
    end

    # global variable:
    # used for sake of simplification and not involving persistant layer 
    def save 
      $parking = OpenStruct.new(number_of_slots: @number_of_slots)
    end

    def allocate
    end

    def find_free_spot
      return false if parking_full?
      slots.index(nil) + 1
    end

    def status
    end

    private
      def parking_full?
        !any_free_space?
      end

      def any_free_space?
        slots.any?{|slot| slot.nil? }
      end
  end

end
