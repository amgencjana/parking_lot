require_relative 'parking_lot/command'
require_relative 'parking_lot/command_strategy'
require_relative 'parking_lot/report'
require_relative 'parking_lot/services/parking_query'

require 'ostruct'

module ParkingLot

  class Parking
    attr_accessor :number_of_slots, :slots, :payload

    def self.current
      $parking
    end

    def initialize(number_of_slots)
      @number_of_slots = number_of_slots
      @slots           = Array.new(@number_of_slots)
    end

    # global variable:
    # used for sake of simplification and not involving persistant layer 
    def save 
      @payload = OpenStruct.new(number_of_slots: @number_of_slots, slots: @slots)
      $parking = self
    end

    def allocate(car)
      position = find_free_spot
      car[:position] = position

      @slots[position - 1] = car 
      return position
    end

    def release(position)
      return false unless slots[position-1]
      
      slots[position-1] = nil 
      true
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
