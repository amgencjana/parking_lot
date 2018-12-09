require 'spec_helper'

RSpec.describe ParkingLot::Commands::CreateParkingLotCommand, type: :aruba do

  describe 'CommandsStrategy' do 

    describe 'Create Parking Lot Command' do 
      let(:command_txt) { 'create_parking_lot 6'}
      subject { described_class.new(command_txt) }


      it 'public interface' do
        expect(subject).to respond_to(:command_txt)
        expect(subject).to respond_to(:number_of_slots)
        expect(subject).to respond_to(:execute)
      end

      describe '#number_of_slots' do
        context 'create 6 lots' do 
          let(:command_txt) { 'create_parking_lot 6'}
          it 'gets proper value of parking lots' do 
            expect(subject.number_of_slots).to eql 6
          end
        end

        context 'create 3 lots' do 
          let(:command_txt) { 'create_parking_lot 3'}
          it 'gets proper value of parking lots' do 
            expect(subject.number_of_slots).to eql 3
          end
        end

        context 'invalid input - lack of space( )' do 
          let(:command_txt) { 'create_parking_lot:4'}
          it 'gets proper value of parking lots' do 
            expect{subject}.to raise_error ParkingLot::Commands::InvalidInputError
            expect{subject}.to raise_error.
              with_message 'Input must include space before argument'
          end
        end

        context 'invalid input - wrong type of arg' do 
          let(:command_txt) { 'create_parking_lot x'}
          it 'gets proper value of parking lots' do 
            expect{subject}.to raise_error ParkingLot::Commands::InvalidArgumentError
            expect{subject}.to raise_error.
              with_message 'Argument must be type of Integer'
          end
        end
      end

      describe '#execute' do 
        let(:command_txt) { 'create_parking_lot 4'}
        it 'generatates desitable output' do
          expect(subject.execute).to eql("Created a parking lot with 4 slots\n")
        end
      end

    end
  end

end

