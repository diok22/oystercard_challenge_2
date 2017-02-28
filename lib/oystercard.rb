class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "Top up balance cannot exceed #{MAXIMUM_BALANCE} pounds" if @balance + money > MAXIMUM_BALANCE
    @balance += money
  end

  def in_journey?
    @in_journey = false
  end

  def touch_in
    fail "Insufficient balance to touch in" if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  private

  def deduct(money)
    @balance -= money
  end

end
