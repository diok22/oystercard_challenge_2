require 'oystercard'

describe Oystercard do

  let(:station){ double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'has zero balance' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by(5)
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "Top up balance cannot exceed #{maximum_balance} pounds"
    end
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it "can touch out" do
    subject.top_up(5)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject).not_to be_in_journey
  end

  it 'will not touch in if below minimum balance' do
    expect{ subject.touch_in(station) }.to raise_error "Insufficient balance to touch in"
  end

  it 'charges the minimum fare on touch out' do
    subject.top_up(5)
    subject.touch_in(station)
    expect{ subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
  end

  it 'stores the entry station' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq(entry_station)
  end

  it 'stores exit station' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

end
