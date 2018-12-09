module ParkingLot
  
  # Class Responsible for printing formatted status
  class Report
    
    attr_accessor :data

    def initialize( data ) 
      @data = data
    end

    def print
      header + table     
    end
    
    private 
      def header 
        "Slot No.    Registration No    Colour\n"
      end

      # require that passed data respond to keys: :position, :license_plate, :color 
      def table 
        table = data.map do |slot|
          slot.position.to_s.ljust(12) + slot.license_plate.ljust(19) + slot.color + "\n" if slot
        end.join('')
      end
      
  end
end
