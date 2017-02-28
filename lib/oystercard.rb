class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "Top up balance cannot exceed #{MAXIMUM_BALANCE} pounds" if @balance + money > MAXIMUM_BALANCE
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end
end
