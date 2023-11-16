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

  def inspect
    @probability.to_s
  end

  alias_method :p, :probability
end