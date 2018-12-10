module ParkingLot
  # Parking
  # 
  # domain class which is responsible for executing majority of
  # the functionalities like add / removing items 
  # to park unpark car on the first available slot
  # 
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
      return false if parking_full?
      
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

    
    def parking_full?
      !any_free_space?
    end

    private

    def any_free_space?
      slots.any?{|slot| slot.nil? }
    end
  end
end