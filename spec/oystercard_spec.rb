require 'oystercard'

describe Oystercard do

  it 'has zero balance' do
    expect(subject.balance).to eq(0)
  end

end
