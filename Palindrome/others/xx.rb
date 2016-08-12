class Palindromes
  def initialize(max_factor: num, min_factor: 0)
    @max_factor = max_factor
    @min_factor = min_factor
  end

  def generate
  if @max_factor == 9
    @largest = 9
    @lg_factor = [[1, 9], [3, 3]]
  else
    @largest, @lg_factor = find_big(@min_factor, @max_factor)
    @smallest, @sm_factor = find_small(@min_factor, @max_factor)
    end
  end

  def find_small(min, max)
    small_a = 1000000
    small_b = 1000000

    a = min
    b = min
    (a..max).to_a.each do |min1|
      (b..max).to_a.each do |min2|
      if palindrome?(min1 * min2) && min1 * min2 < small_a * small_b
        small_a = min1
        small_b = min2
        break
      end
      if small_a * small_b <= min1 * min
        return small_a * small_b, [[small_a, small_b]]
      end
      b = a + 1
      end
    end
  end

  def find_big(min, max)
    big_a = 0
    big_b = 0
    a = max
    b = max
    (min..a).to_a.reverse.each do |max1|
      (min..b).to_a.reverse.each do |max2|
        if palindrome?(max1 * max2) && max1 * max2 > big_a * big_b
          big_a = max1
          big_b = max2
          break
        end
      if big_a * big_b >= max1 * max
        return big_a * big_b, [[big_b, big_a]]
      end
      b = a -1
      end
    end
  end

  def palindrome?(number)
    num_s = number.to_s
    return true if num_s == num_s.reverse
    false
  end

  def largest
    Factors.new(@largest, @lg_factor)
  end

  def smallest
    Factors.new(@smallest, @sm_factor)
  end
end

class Factors
  attr_reader :value, :factors

  def initialize(value, factors)
    @value = value
    @factors = factors
  end
end
