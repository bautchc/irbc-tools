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