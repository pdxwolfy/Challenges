class Palindromes
  FactoredValue = Struct.new :value, :factors

  def initialize(max_factor:, min_factor: 1)
    @range = min_factor..max_factor
  end

  def generate
  end

  def largest
    factored_value(@range.to_a.reverse) { |target, product| product >= target }
  end

  def smallest
    factored_value(@range.to_a) { |target, product| product <= target }
  end

  private

  def factored_value(range)
    factors = []
    target = range.last**2
    range.repeated_combination(2).each do |factor1, factor2|
      product = factor1 * factor2
      next unless yield(target, product) && palindromic?(product.to_s)

      factors = [] unless target == product
      factors << [factor1, factor2].sort
      target = product
    end

    FactoredValue.new target, factors
  end

  def palindromic?(string)
    string == string.reverse
  end
end
