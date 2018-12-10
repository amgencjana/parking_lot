require 'spec_helper'


RSpec.describe ParkingLot::CommandStrategy, type: :aruba do

  describe 'loads properly Commands' do 
    subject { ParkingLot::CommandStrategy::AVAILABLE_COMMANDS }
    
    it { is_expected.to include(ParkingLot::Commands::CreateParkingLotCommand) }
    it { is_expected.to include(ParkingLot::Commands::ParkCar) }
    it { is_expected.to include(ParkingLot::Commands::LeavePosition) }
    it { is_expected.to include(ParkingLot::Commands::Status) }
    it { is_expected.to include(ParkingLot::Commands::RegistrationNumberForColour) }
    it { is_expected.to include(ParkingLot::Commands::SlotsNumberForColour) }
    it { is_expected.to include(ParkingLot::Commands::SlotNumberForRegistration) }
  end

  describe 'CommandsStrategy' do 
    subject { ParkingLot::CommandStrategy.new(command_txt) }

    describe 'Create Parking Lot Command' do 
      let(:command_txt) { 'create_parking_lot 6'}

      it 'public interface' do
        expect(subject).to respond_to(:command)
      end

      it 'finds proper Command based on the input' do
        expect(subject.command).to be_kind_of(ParkingLot::Commands::CreateParkingLotCommand)
      end
    end

    describe 'Park a Car Command' do 
      let(:create_parking) { 'create_parking_lot 6'}
      
      before do 
        ParkingLot::CommandStrategy.new(create_parking).command.execute
      end

      let(:command_txt) { 'park AMG_C63 White'}

      it 'finds proper Command based on the input' do
        expect(subject.command).to be_kind_of(ParkingLot::Commands::ParkCar)
        expect(subject.command.execute).to eql("Allocated slot number: 1\n")
      end

      context 'Park multiple cars' do
        let(:create_parking) { 'create_parking_lot 6'}
        let(:park_car_1)  { 'park AMG_C63 White'}
        let(:command_txt) { 'park BMW_430 Silver'}
        before do 
          ParkingLot::CommandStrategy.new(create_parking).command.execute 
          ParkingLot::CommandStrategy.new(park_car_1).command.execute 
        end
        it 'finds proper Command based on the input' do
          expect(subject.command.execute).to eql("Allocated slot number: 2\n")
        end
      end
    end

    describe 'Leave Position Command' do 
      let(:command_txt) { 'leave 2' }

      it 'finds proper Command based on the input' do
        expect(subject.command).to be_kind_of(ParkingLot::Commands::LeavePosition)
        expect(subject.command.execute).to eql("Slot number 2 is free\n")
      end

      context 'Leave already parked multiple cars' do
        let(:create_parking) { 'create_parking_lot 6'}
        let(:park_car_1)  { 'park AMG_C63 White'}
        let(:park_car_2)  { 'park BMW_430 Silver'}
        let(:park_car_3)  { 'park BMW_M5 Silver'}
        let(:park_car_4)  { 'park AMG_S63 Silver'}
        before do 
          ParkingLot::CommandStrategy.new(create_parking).command.execute 
          ParkingLot::CommandStrategy.new(park_car_1).command.execute 
          ParkingLot::CommandStrategy.new(park_car_2).command.execute 
          ParkingLot::CommandStrategy.new(park_car_3).command.execute 
          ParkingLot::CommandStrategy.new(park_car_4).command.execute 
        end

        it 'prints out proper output message' do

          expect(subject.command.execute).to eql("Slot number 2 is free\n")
        end

        context 'Position is not occupated' do 
          let(:command_txt) { 'leave 5' }
          
          it 'prints out proper output message' do
            expect(subject.command.execute).to eql("No Car on this position\n")
          end
        end

      end
    end

    describe 'Status Command' do 
      let(:command_txt) { 'status' }

      it 'finds proper Command based on the input' do
        expect(subject.command).to be_kind_of(ParkingLot::Commands::Status)
      end

      describe 'Print out status of parked cars' do
        let(:create_parking) { 'create_parking_lot 6'}
        let(:park_car_1)  { 'park AMG_C63 White'}
        let(:park_car_2)  { 'park BMW_430 Silver'}
        let(:park_car_3)  { 'park BMW_M5 Gold'}
        
        before do 
          ParkingLot::CommandStrategy.new(create_parking).command.execute 
          ParkingLot::CommandStrategy.new(park_car_1).command.execute 
          ParkingLot::CommandStrategy.new(park_car_2).command.execute 
          ParkingLot::CommandStrategy.new(park_car_3).command.execute 
        end
       
       let(:report) do
<<-STATUSTEXT
Slot No.    Registration No    Colour
1           AMG_C63            White
2           BMW_430            Silver
3           BMW_M5             Gold
STATUSTEXT
        end

        it 'prints out proper output message' do
          expect(subject.command.execute).to eql(report)
        end
      end
    end
   

    describe 'Registration Number For Colours a Car Command' do 
      let(:create_parking) { 'create_parking_lot 6'}
      let(:park_car_1)  { 'park AMG_C63 White'}
      
      before do 
        ParkingLot::CommandStrategy.new(create_parking).command.execute
        ParkingLot::CommandStrategy.new(park_car_1).command.execute 
      end

      let(:command_txt) { 'registration_numbers_for_cars_with_colour White'}

      it 'finds proper Command based on the input' do
        expect(subject.command).to be_kind_of(ParkingLot::Commands::RegistrationNumberForColour)
        expect(subject.command.execute).to eql("AMG_C63")
      end

      context 'Park multiple cars' do
        let(:create_parking) { 'create_parking_lot 6'}
        let(:park_car_1) { 'park AMG_C63 White'}
        let(:park_car_2) { 'park BMW_430 White'}

        before do 
          ParkingLot::CommandStrategy.new(create_parking).command.execute 
          ParkingLot::CommandStrategy.new(park_car_1).command.execute 
          ParkingLot::CommandStrategy.new(park_car_2).command.execute 
        end
        
        let(:command_txt) { 'registration_numbers_for_cars_with_colour White'}

        it 'returns licence plates of found cars' do
          expect(subject.command.execute).to eql("AMG_C63, BMW_430")
        end
      end
    end

    describe 'Slots Numbers For Colours Command' do 
      let(:command_txt) { 'slot_numbers_for_cars_with_colour White'}

      it 'finds proper Command based on the input' do
        expect(subject.command).to be_kind_of(ParkingLot::Commands::SlotsNumberForColour)
      end
    end


    describe 'Slot Number Based on License plate Command' do 
      let(:create_parking) { 'create_parking_lot 6'}
      let(:park_car_1)  { 'park AMG_C63 White'}
      
      before do 
        ParkingLot::CommandStrategy.new(create_parking).command.execute
        ParkingLot::CommandStrategy.new(park_car_1).command.execute 
      end

      let(:command_txt) { 'slot_number_for_registration_number AMG_C63'}

      it 'finds proper Command based on the License platenput' do
        expect(subject.command).to be_kind_of(ParkingLot::Commands::SlotNumberForRegistration)
        
      end

      it 'return value of the parking slot based on the License plate' do
        expect(subject.command.execute).to eql("1")
      end
    end

  end

  

  describe "full scenarios" do
    let(:commands) do
      [
          "create_parking_lot 6\n",
          "park KA-01-HH-1234 White\n",
          "park KA-01-HH-9999 White\n",
          "park KA-01-BB-0001 Black\n",
          "park KA-01-HH-7777 Red\n",
          "park KA-01-HH-2701 Blue\n",
          "park KA-01-HH-3141 Black\n",
          "leave 4\n",
          "status\n",
          "park KA-01-P-333 White\n",
          "park DL-12-AA-9999 White\n",
          "registration_numbers_for_cars_with_colour White\n",
          "slot_numbers_for_cars_with_colour White\n",
          "slot_number_for_registration_number KA-01-HH-3141\n",
          "slot_number_for_registration_number MH-04-AY-1111\n"
      ]
    end
  end
end

