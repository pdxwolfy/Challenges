module LargeSmall
  def initialize(args)
    @value = args[0]
    @factors = args[1]
  end

  def value
    @value
  end

  def factors
    @factors
  end
end

class Palindromes
  def initialize(args)
    @max_factor = args[:max_factor]
    @min_factor = args[:min_factor] || 0
    @range = (@min_factor..@max_factor).to_a
  end

  def generate
    @largest_product, @largest_factor1, @largest_factor2 = find_largest
    @smallest_product, @smallest_factor1, @smallest_factor2 = find_smallest
  end

  def largest
    Largest.new([@largest_product, [[@largest_factor1, @largest_factor2]]])
  end

  def smallest
    Smallest.new([@smallest_product, [[@smallest_factor1, @smallest_factor2]]])
  end

  private

  def palindrome?(num)
    num.to_s == num.to_s.reverse
  end

  def find_largest
    range = @max_factor - @min_factor
    i, j, n, product = range, range, 0, 0
    while j >= 0
      i = range - n
      j = range
      while i <= range
        product = @range[i] * @range[j]
        break if palindrome?(product)
        i += 1
        j -= 1
      end
      break if palindrome?(product)
      n += 1
    end
    [product, @range[i], @range[j]]
  end

  def find_smallest
    i, j, n, product = 0, 0, 0, 0
    while j <= @max_factor - @min_factor
      i = n
      j = 0
      while i >= 0
        product = @range[i] * @range[j]
        break if palindrome?(product)
        i -= 1
        j += 1
      end
      break if palindrome?(product)
      n += 1
    end
    [product, @range[i], @range[j]]
  end
end

class Largest
  include LargeSmall
end

class Smallest
  include LargeSmall
end
