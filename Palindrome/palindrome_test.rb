require 'minitest/autorun'
#require 'minitest/benchmark'
#require_relative 'palindrome_products_3'
require_relative 'x'

class PalindromesTest < Minitest::Test
  def test_largest_palindrome_from_single_digit_factors
    palindromes = Palindromes.new(max_factor: 9)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 9, largest.value
    assert_includes [[[3, 3], [1, 9]], [[1, 9], [3, 3]]], largest.factors
  end

  def test_largest_palindrome_from_double_digit_factors
    palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 9009, largest.value
    assert_equal [[91, 99]], largest.factors
  end

  def test_smallest_palindrome_from_double_digit_factors
    palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
    palindromes.generate
    smallest = palindromes.smallest
    assert_equal 121, smallest.value
    assert_equal [[11, 11]], smallest.factors
  end

  def test_largest_palindrome_from_triple_digit_factors
    palindromes = Palindromes.new(max_factor: 999, min_factor: 100)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 906_609, largest.value
    assert_equal [[913, 993]], largest.factors
  end

  def test_smallest_palindrome_from_triple_digit_factors
    palindromes = Palindromes.new(max_factor: 999, min_factor: 100)
    palindromes.generate
    smallest = palindromes.smallest
    assert_equal 10_201, smallest.value
    assert_equal [[101, 101]], smallest.factors
  end

  def test_smallest_palindrome_from_4_digit_factors
    palindromes = Palindromes.new(max_factor: 4321, min_factor: 1234)
    palindromes.generate
    smallest = palindromes.smallest
    assert_equal 1_639_361, smallest.value
    assert_equal [[1241, 1321]], smallest.factors
  end

  def test_smallest_palindrome_profiling
    palindromes = Palindromes.new(max_factor: 1500, min_factor: 1)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 2_150_512, largest.value
    assert_equal [[1456, 1477]], largest.factors
  end
end

# class PalindromesBench < Minitest::Benchmark
#   def self.bench_range
#     bench_exp 1000, 10_000_000, 7
#   end
#
#   def bench_constant_1
#     assert_performance_constant 0.999 do |n|
#       palindromes = Palindromes.new(max_factor: n, min_factor: 1)
#       palindromes.generate
#       largest = palindromes.largest
#       largest.factors
#       largest.value
#     end
#   end
#
#   def bench_constant_2
#     assert_performance_constant 0.999 do |n|
#       palindromes = Palindromes.new(max_factor: 10 * n, min_factor: n)
#       palindromes.generate
#       smallest = palindromes.smallest
#       smallest.factors
#       smallest.value
#     end
#   end
#
#   # def bench_constant_1
#   #   assert_performance_linear 0.99 do |n|
#   #     palindromes = Palindromes.new(max_factor: n, min_factor: 1)
#   #     palindromes.generate
#   #     largest = palindromes.largest
#   #     largest.factors
#   #     largest.value
#   #   end
#   # end
#   #
#   # def bench_constant_2
#   #   assert_performance_linear 0.99 do |n|
#   #     palindromes = Palindromes.new(max_factor: 10_000 * n,
#   #                                   min_factor: 10**(n - 1))
#   #     palindromes.generate
#   #     largest = palindromes.largest
#   #     largest.factors
#   #     largest.value
#   #   end
#   # end
# end
