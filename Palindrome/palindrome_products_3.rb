require 'set'

class Palindromes
  FactoredValue = Struct.new :value, :factors

  def initialize(max_factor:, min_factor: 1)
    @range = min_factor..max_factor
    @factors = []
  end

  def generate
  end

  def largest
    args = { from: @range.last, to: @range.first, by: -1 }
    find_palindrome(args) { |max_product, product| product >= max_product }
  end

  def smallest
    args = { from: @range.first, to: @range.last }
    find_palindrome(args) { |min_product, product| product <= min_product }
  end

  private

  def find_palindrome by: 1, from:, to:
    value = to * to
    factors = []
    from.step(to: to, by: by) do |factor1|
      start, stop = (by == 1) ? [factor1, to] : [from, factor1]
      start.step(to: stop, by: by) do |factor2|
        product = factor1 * factor2
        break unless yield value, product
        next unless palindromic? product.to_s

        factors = [] unless value == product
        factors << [factor1, factor2]
        value = product
      end
    end

    FactoredValue.new value, factors
  end

  def palindromic?(string)
    string == string.reverse
  end
end
