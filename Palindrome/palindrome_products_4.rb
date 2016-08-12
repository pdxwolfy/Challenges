class Palindromes
  def initialize(max_factor:, min_factor: 1)
    @min_factor = min_factor
    @max_factor = max_factor
  end

  def smallest
    1.step(to: @max_factor - @min_factor + 1) do |cycle|
      1.step(to: cycle) do |bin|
        factor1 = @min_factor + (bin - 1)
        factor2 = @min_factor + (cycle - bin)
        break if factor1 > factor2

        product = factor1 * factor2
        return product if palindromic? product.to_s
        break if factor1 == factor2
      end
    end
  end

  def largest
    1.step(to: @max_factor - @min_factor + 1) do |cycle|
      cycle.step(to: 1, by: -1) do |bin|
        factor1 = @max_factor - (bin - 1)
        factor2 = @max_factor - (cycle - bin)
        break if factor1 > factor2

        product = factor1 * factor2
        return product if palindromic? product.to_s
        break if factor1 == factor2
      end
    end
  end

  private

  def palindromic?(string)
    string == string.reverse
  end
end

if __FILE__ == $PROGRAM_NAME
  9.times do |n|
    puts Palindromes.new(min_factor:5**n, max_factor: 10**n).smallest
  end

  9.times do |n|
    puts Palindromes.new(min_factor:5**n, max_factor: 10**n).largest
  end
end

#      1    2    3    4    5    6    7    8    9
#   +----+----+----+----+----+----+----+----+----+
# 1 |  1 |  2 |  3 |  4 |  5 |  6 |  7 |  8 |  9 |
#   +----+----+----+----+----+----+----+----+----+
# 2 |    |  4 |  6 |  8 | 10 | 12 | 14 | 16 | 18 |
#   +----+----+----+----+----+----+----+----+----+
# 3 |    |    |  9 | 12 | 15 | 18 | 21 | 24 | 27 |
#   +----+----+----+----+----+----+----+----+----+
# 4 |    |    |    | 16 | 20 | 24 | 28 | 32 | 36 |
#   +----+----+----+----+----+----+----+----+----+
# 5 |    |    |    |    | 25 | 30 | 35 | 40 | 45 |
#   +----+----+----+----+----+----+----+----+----+
# 6 |    |    |    |    |    | 36 | 42 | 48 | 54 |
#   +----+----+----+----+----+----+----+----+----+
# 7 |    |    |    |    |    |    | 49 | 56 | 63 |
#   +----+----+----+----+----+----+----+----+----+
# 8 |    |    |    |    |    |    |    | 64 | 72 |
#   +----+----+----+----+----+----+----+----+----+
# 9 |    |    |    |    |    |    |    |    | 81 |
#   +----+----+----+----+----+----+----+----+----+

# 1,1
# 1,2 2,1
# 1,3 2,2 3,1
# 1,4 2,3 3,2 4,1
