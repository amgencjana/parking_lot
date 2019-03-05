require 'spec_helper'

RSpec.describe ParkingLot::ParkingLots, type: :aruba do

  context 'Mulitple Parking lots' do
    describe 'initialization' do 
      let(:parking_lot_1) { ParkingLot::Parking.new(5) }
      let(:parking_lot_2) { ParkingLot::Parking.new(3) }
      
      subject { ParkingLot::ParkingLots.new }

      describe 'public interface' do 
        it 'expose a methods' do 
          expect(subject).to respond_to(:add_parking)
          expect(subject).to respond_to(:count)
        end
      end


      describe '#add_parking' do 
        before { subject.add_parking(parking_lot_1) }

        it 'returns Parking obejct' do
          expect(subject.parking_lots.first).to be_kind_of(ParkingLot::Parking)
        end
      end

      describe '#count' do 
        let(:parking_lots) { ParkingLot::ParkingLots.new }

        before do 
          parking_lots.add_parking(parking_lot_1)
          parking_lots.add_parking(parking_lot_2)
        end

        it 'create mulitple lots' do 
          expect(parking_lots.count).to eql(2)
        end      
      end

    end
   
  end
end