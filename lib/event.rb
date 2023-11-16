class Event
  attr_reader :probability

  def initialize(probability)
    @probability = probability
  end

  def &(other)
    Event.new(probability * other.probability)
  end

  def |(other)
    Event.new(probability + other.probability - (self & other).probability)
  end

  def !
    Event.new(1 - probability)
  end

  def >>(times)
    (times - 1).times.reduce(self) {|product, _| product & self}
  end

  def <<(times)
    (times - 1).times.reduce(self) {|sum, _| sum | self}
  end

  def to_f
    @probability
  end

  def *(other)
    @probability * other.to_f
  end

  def +(other)
    @probability + other.to_f
  end

  def inspect
    @probability.to_s
  end

  alias_method :p, :probability
end