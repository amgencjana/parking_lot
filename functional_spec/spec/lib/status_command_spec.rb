require 'spec_helper'

RSpec.describe ParkingLot::Commands::Status, type: :aruba do

  describe 'CommandsStrategy' do 

    describe 'Status Command' do 
      let(:command_txt) { 'status'}
      subject { described_class.new(command_txt) }


      it 'public interface' do
        expect(subject).to respond_to(:execute)
      end

    
      describe '#execute' do 
        let(:create_parking) { 'create_parking_lot 6'}
        let(:park_car_1)  { 'park AMG_C63 White'}
        let(:park_car_2)  { 'park BMW_430 Silver'}
        
        before do 
          ParkingLot::CommandStrategy.new(create_parking).command.execute 
          ParkingLot::CommandStrategy.new(park_car_1).command.execute 
          ParkingLot::CommandStrategy.new(park_car_2).command.execute 
        end

        let(:report) do
<<-STATUSTEXT
Slot No.    Registration No    Colour
1           AMG_C63            White
2           BMW_430            Silver
STATUSTEXT
        end

        it 'prints out report' do
          expect(subject.execute).to eql(report)
        end


        context 'keeps order of cars leaving' do
          let(:create_parking) { 'create_parking_lot 6'}
          let(:park_car_1)  { 'park AMG_C63 White'}
          let(:park_car_2)  { 'park BMW_430 Silver'}
          let(:park_car_3)  { 'park BMW_M5 Gold'}
          let(:park_car_4)  { 'park gonna_leave Blue'}
          let(:leave_4)     { 'leave 4'}
          let(:park_car_5)  { 'park AMG_S63 Silver'}
          before do 
            ParkingLot::CommandStrategy.new(create_parking).command.execute 
            ParkingLot::CommandStrategy.new(park_car_1).command.execute 
            ParkingLot::CommandStrategy.new(park_car_2).command.execute 
            ParkingLot::CommandStrategy.new(park_car_3).command.execute 
            ParkingLot::CommandStrategy.new(park_car_4).command.execute 
            ParkingLot::CommandStrategy.new(park_car_5).command.execute 
            ParkingLot::CommandStrategy.new(leave_4).command.execute 
          end

          let(:report) do
<<-STATUSTEXT
Slot No.    Registration No    Colour
1           AMG_C63            White
2           BMW_430            Silver
3           BMW_M5             Gold
5           AMG_S63            Silver
STATUSTEXT
          end

          it 'prints out proper output message' do
            expect(subject.execute).to eql(report)
          end
        end
      end

    end
  end

end

