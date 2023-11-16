class Event
  attr_reader :probability

  def initialize(probability)
    @probability = probability
  end

  def &(other)
    Event.new(probability * other.probability)
  end

  def |(other)
    Event.new(probability + other.probability - self & other)
  end

  alias_method :p, :probability
end