class Palindromes
  FactoredValue = Struct.new :value, :factors

  def initialize(max_factor:, min_factor: 1)
    @range = min_factor..max_factor
  end

  def generate
    @factors = grouped palindromic_values
  end

  def largest
    factored_value @factors.keys.max
  end

  def smallest
    factored_value @factors.keys.min
  end

  private

  def factored_value(value)
    FactoredValue.new value, @factors[value]
  end

  def grouped(values) # {1=>[[1, 1]], 2->[[1, 2]], 4=>[[1, 4], [2,2]}
    values.group_by { |number1, number2| number1 * number2 }
  end

  def palindromic_values
    @range.to_a.repeated_combination(2).select do |number1, number2|
      value_as_str = (number1 * number2).to_s
      value_as_str == value_as_str.reverse
    end
  end
end
