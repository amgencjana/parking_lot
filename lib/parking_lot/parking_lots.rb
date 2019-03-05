module ParkingLot

  class ParkingLots
    attr_accessor :parking_lots

    def initialize 
      @parking_lots = []
    end

    def add_parking(parking)
      @parking_lots << parking
    end

    def count
      @parking_lots.count
    end


    def dispatch
      @parking_lots.select{|parking| parking.any_free_space? }.first
    end

  end

end