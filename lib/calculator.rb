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

# Some methods to simplify using the irb as a calculator.

class Integer
  def /(other)
    self.fdiv(other)
  end

  def ^(other)
    self ** other
  end
end

class Float
  def inspect
    self.round(13).to_s
  end
end

class Array
  def roots
    if self.length == 2
      -self[1] / self[0]
    elsif self.length == 3
      [1, -1].map {|sign| (-self[1] + sign * (self[1] ** 2 - 4 * self[0] * self[2]) ** 0.5) / (2 * self[0])}
    else
      nil
    end
  end
end