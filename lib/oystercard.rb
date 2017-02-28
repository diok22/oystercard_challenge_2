class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "Top up balance cannot exceed #{MAXIMUM_BALANCE} pounds" if @balance + money > MAXIMUM_BALANCE
    @balance += money
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    fail "Insufficient balance to touch in" if @balance < MINIMUM_FARE
    @entry_station = entry_station
    @in_journey = true
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = exit_station
  end

  private

  def deduct(money)
    @balance -= money
  end

end
