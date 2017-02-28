require 'oystercard'

describe Oystercard do

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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts an amount from the balance' do
      subject.top_up(10)
      expect{ subject.deduct(2.5)}.to change{ subject.balance }.by(-2.5)
    end
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it "can touch out" do
    subject.top_up(5)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'will not touch in if below minimum balance' do
    expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in"
  end

end
