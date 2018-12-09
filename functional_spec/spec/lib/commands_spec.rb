require 'spec_helper'

RSpec.describe 'Commands', type: :aruba do
  it 'loads properly Commands' do 
  
  end

  describe 'CommandsStrategy' do 

    describe 'Create Parking Lot Command' do 
      let(:command_txt) { 'create_parking_lot 6'}
      subject { ParkingLot::CommandStrategy.new(command_txt) }

      it 'public interface' do
        expect(subject).to respond_to(:command)
      end

      it 'finds proper Command based on the input' do
        expect(subject.command).to be_kind_of(ParkingLot::Commands::CreateParkingLotCommand)
      end

    end
  end

  xit "has aruba set up" do
    command = run "echo 'hello world'"
    stop_all_commands
    expect(command.output).to eq("hello world\n")
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

