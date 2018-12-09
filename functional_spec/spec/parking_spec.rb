require 'spec_helper'

RSpec.describe ParkingLot::Parking, type: :aruba do
  
  describe 'public interface' do 
    subject { described_class.new(6) }

    it 'public interface' do
      expect(subject).to respond_to(:save)
      expect(subject).to respond_to(:allocate)
      expect(subject).to respond_to(:slots)
      expect(subject).to respond_to(:number_of_slots)
      expect(subject).to respond_to(:find_free_spot)
    end
  end

  describe '#slots' do
    let(:number_of_slots) { 6 }
    subject { described_class.new(number_of_slots) }

    it 'has given number of slots' do
      expect(subject.number_of_slots).to eql(number_of_slots)
      expect(subject.slots).to eql(Array.new(number_of_slots))
    end
  end

  describe '#find_free_spot' do 
    let(:number_of_slots) { 6 }
    subject { described_class.new(number_of_slots) }

    context 'empty parking' do
      it 'returns position of first free slots' do
        expect(subject.find_free_spot).to eql 1
      end
    end

    context 'parking has allocated 2 cars' do
      let(:car)   { double :car }
      let(:car_2) { double :car }
      let(:stubbed_slots) { [car, car_2, nil, nil, nil, nil] } 
      before do 
        allow_any_instance_of(described_class).to receive(:slots).and_return(stubbed_slots)
      end

      it 'returns position of first free slots' do
        expect(subject.find_free_spot).to eql 3
      end
    end 

    context 'parking is FULL' do
      let(:car)   { double :car }
      
      let(:number_of_slots) { 6 }
      subject { described_class.new(number_of_slots) }
      
      let(:stubbed_slots) { Array.new(number_of_slots){ car } } 
      
      before do 
        allow_any_instance_of(described_class).to receive(:slots).and_return(stubbed_slots)
      end

      it 'returns false in when parking is FULL' do
        expect(subject.find_free_spot).to eql false
      end
    end 
  end

  describe '#save' do
  end

  describe '#allocate' do
    # ensure to received .find_free_spot
  end
end

