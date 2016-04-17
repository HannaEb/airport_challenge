require 'airport'

describe Airport do
  subject(:airport) { described_class.new }
  it { expect(subject).to respond_to(:land).with(1).argument}
  it { expect(subject).to respond_to(:take_off).with(1).argument}
  let (:plane) { double :plane }

  describe 'landing plane' do

    it 'instructs plane to land' do
      expect(plane).to receive(:land)
      subject.land(plane)
    end

    it 'confirms plane is in airport' do
      allow(plane).to receive(:land)
      subject.land(plane)
      expect(subject.planes).to include(plane)
    end

    it 'prevents landing when airport is full' do
      allow(subject).to receive(:full?) {true}
      allow(plane).to receive(:land)
      expect {subject.land(plane)}.to raise_error 'Airport is full'
    end

    it 'prevents landing when stormy' do
      allow(subject).to receive(:stormy?) {true}
      allow(plane).to receive(:land)
      expect {subject.land(plane)}.to raise_error 'Too windy to land'
    end

    it 'allows landing when storm is over' do
      allow(subject).to receive(:stormy?) {false}
      allow(plane).to receive(:land)
      expect {subject.land(plane)}.not_to raise_error
    end

  end

  describe 'taking off plane' do

    it 'instructs plane to take off' do
      expect(plane).to receive(:take_off)
      subject.take_off(plane)
    end

    it 'confirms plane left airport' do
      allow(plane).to receive(:land)
      allow(plane).to receive(:take_off)
      subject.land(plane)
      subject.take_off(plane)
      expect(subject.planes).not_to include(plane)
    end

    it 'prevents take off when stormy' do
      allow(subject).to receive(:stormy?) {true}
      allow(plane).to receive(:take_off)
      expect {subject.take_off(plane)}.to raise_error 'Too windy to take off'
    end

    it 'allows taking off when storm is over' do
      allow(subject).to receive(:stormy?) {false}
      allow(plane).to receive(:take_off)
      expect {subject.take_off(plane)}.not_to raise_error
    end

  end
end







