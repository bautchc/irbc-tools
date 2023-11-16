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

def mean(array)
  array.sum / array.length.to_f
end

def fl(n) factorial(n) end
def p(n, k) P(n, k) end
def c(n, k) C(n, k) end
def mn(array) mean(array) end

# Monkeypatching below this point. Use at your own risk.

class Integer
  def !@
    factorial
  end

  def factorial
    (1..self).reduce(:*) || 1
  end

  alias_method :fl, :factorial
end

class Array
  def mean 
    sum / length.to_f
  end

  alias_method :mn, :mean
end