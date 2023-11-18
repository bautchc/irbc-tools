# frozen_string_literal: true

# MIT No Attribution
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# A few simple methods for calculating probability.

def factorial(n)
  (1..n).reduce(:*) || 1
end

def P(n, k)
  factorial(n) / factorial(n - k)
end

def C(n, k)
  factorial(n) / (factorial(k) * factorial(n - k))
end

def b(x, n, p)
  C(n, x) * p ** x * (1 - p) ** (n - x)
end

def poisson(x, mu)
  (mu ** x * Math.exp(-mu)) / factorial(x)
end

def phi(z)
  0.5 * (1 + Math.erf(z / Math.sqrt(2)))
end


def ci(x_bar, sigma, n, confidence_level)
  margin_of_error = Statistics2.pnormaldist((1 + confidence_level) / 2) * (sigma / Math.sqrt(n))

  [x_bar - margin_of_error, x_bar + margin_of_error]
end

def n_for_width(loc, sigma, w)
  (2 * Statistics2.pnormaldist((1 + loc) / 2) * sigma / w) ** 2
end

def confidence_level(z_alpha_over_2)
  1 - 2 * (1 - Statistics2.pnormaldist(z_alpha_over_2))
end

def prop_ci(sample_proportion, sample_size, confidence_level)
  z = Statistics2.pnormaldist((1 + confidence_level) / 2)
  margin_of_error = z * Math.sqrt((sample_proportion * (1 - sample_proportion)) / sample_size)

  lower_bound = sample_proportion - margin_of_error
  upper_bound = sample_proportion + margin_of_error

  [lower_bound, upper_bound]
end

def t(confidence_level, degrees_of_freedom)
  alpha = 1 - confidence_level
  t = Statistics2.t(alpha / 2, degrees_of_freedom)
end

class Bin
  def initialize(n, p)
    @n = n
    @p = p
  end

  def p(lower, upper=nil)
    if upper
      (lower..upper).map {|x| b(x, @n, @p)}.sum
    else
      b(lower, @n, @p)
    end
  end

  def mu 
    @n * @p
  end

  def sigma
    (@n * @p * (1 - @p)) ** 0.5
  end

  def sigma2
    @n * @p * (1 - @p)
  end

  def inspect
    "{n: #{@n}, p: #{@p}}"
  end
end

class Poisson
  def initialize(mu)
    @mu = mu
  end

  def p(lower, upper=nil)
    if upper
      (lower..upper).map {|x| poisson(x, @mu)}.sum
    else
      poisson(lower, @mu)
    end
  end

  def mu
    @mu
  end

  def sigma
    @mu ** 0.5
  end

  def sigma2
    @mu
  end

  def inspect
    "{mu: #{@mu}}"
  end
end

class N
  def initialize(mu, sigma)
    @mu = mu
    @sigma = sigma
  end

  def phi(x)
    0.5 * (1 + Math.erf((x - @mu) / @sigma / Math.sqrt(2)))
  end
end

class Exponential
  def initialize(lambda_)
    @lambda = lambda_
  end

  def p(lower, upper=nil)
    if upper
      p(upper) - p(lower)
    else
      @lambda - Math.exp(-@lambda * lower)
    end
  end

  def mu
    1 / @lambda
  end

  def sigma
    1 / @lambda
  end

  def sigma2
    1 / @lambda ** 2
  end

  def inspect
    "{lambda: #{@lambda}}"
  end
end

# Monkeypatching below this point. Use at your own risk.

class Integer
  def !@
    factorial
  end

  def factorial
    (1..self).reduce(:*) || 1
  end
end

class Array
  def mean(trim = 0, type = :fraction)
    if type == :fraction
      trim = trim * self.length
    end
    (self.sort[trim.ceil..-(trim.ceil) - 1].sum + (trim - trim.to_i) * (self[trim.ceil - 1] + self[-(trim.ceil)])) \
    / (self.length - 2 * trim)
  end
end