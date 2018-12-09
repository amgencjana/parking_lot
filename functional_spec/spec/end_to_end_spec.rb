require 'spec_helper'

RSpec.describe 'End To End Suite', type: :aruba do
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

    let(:expected) do
      <<-EOTXT
Created a parking lot with 6 slots
Allocated slot number: 1
Allocated slot number: 2
Allocated slot number: 3
Allocated slot number: 4
Allocated slot number: 5
Allocated slot number: 6
Slot number 4 is free
Slot No.    Registration No    Colour
1           KA-01-HH-1234      White
2           KA-01-HH-9999      White
3           KA-01-BB-0001      Black
5           KA-01-HH-2701      Blue
6           KA-01-HH-3141      Black
Allocated slot number: 4
Sorry, parking lot is full
KA-01-HH-1234, KA-01-HH-9999, KA-01-P-333
1, 2, 4
6
Not found
EOTXT
    end

    xit "input from file" do
      command = run("parking_lot #{File.join(File.dirname(__FILE__), '..', 'fixtures', 'file_input.txt')}")
      stop_all_commands
      expect(command.stdout).to eq(expected)
    end

    xit "interactive input" do
      command = run("parking_lot")
      commands.each {|cmd| command.write(cmd)}
      stop_all_commands
      expect(command.stdout).to eq(expected)
    end

    describe 'my approach' do 

      let(:output) do
<<-MYARGS
Created a parking lot with 6 slots
Created a parking lot with 2 slots
Allocated slot number: 1
MYARGS
      end

      it 'interactive go input' do
        command = run("parking_lot")
        
        command.write("create_parking_lot 6\n")
        command.write("create_parking_lot 2\n")
        command.write("park CAR_AMG White\n")
        
        stop_all_commands
        
        expect(command.stdout).to eq(output)
      end

      let(:parking_lots_3) { "Created a parking lot with 3 slots\n" }
      it 'creates given number of parking lots' do
        command = run("parking_lot")
        command.write("create_parking_lot 3\n")
        stop_all_commands

        expect(command.stdout).to eq(parking_lots_3)
      end
    end
  end
end

