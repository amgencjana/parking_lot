require 'spec_helper'

RSpec.describe ParkingLot::Commands::RegistrationNumberForColours, type: :aruba do


  describe 'Registration Numbers For Colours Command' do 
    let(:command_txt) { 'registration_numbers_for_cars_with_colour White'}
    subject { described_class.new(command_txt) }


    it 'public interface' do
      expect(subject).to respond_to(:execute)
      expect(subject).to respond_to(:color)
    end

    describe '#color' do
      it 'recognie properly colour' do 
        expect(subject.color).to eql('White') 
      end
    end
  
    describe '#execute' do 
      let(:create_parking) { 'create_parking_lot 6'}
      let(:park_car_1)  { 'park AMG_C63 White'}
      let(:park_car_2)  { 'park BMW_430 Silver'}
      let(:park_car_3)  { 'park BMW_M4  White'}
      
      before do 
        ParkingLot::CommandStrategy.new(create_parking).command.execute 
        ParkingLot::CommandStrategy.new(park_car_1).command.execute 
        ParkingLot::CommandStrategy.new(park_car_2).command.execute 
        ParkingLot::CommandStrategy.new(park_car_3).command.execute 
      end


      it 'finds Registration Numbers based on the colour' do
        expect(subject.execute).to eql('AMG_C63, BMW_M4')
      end
    end
  end
end

