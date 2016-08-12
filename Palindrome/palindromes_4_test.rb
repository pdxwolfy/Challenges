require 'minitest/autorun'
require 'minitest/benchmark'
require_relative 'palindrome_products_4'

class PalindromesBench < Minitest::Benchmark
  def self.bench_range
    bench_exp 1, 7**13, 7
  end

  # def bench_largest
  #   assert_performance_constant 0.9999999 do |n|
  #     Palindromes.new(max_factor: n, min_factor: n / 57).largest
  #   end
  # end

  def bench_smallest
    assert_performance_constant 0.9999999 do |n|
      Palindromes.new(max_factor: 57 * n, min_factor: n).smallest
    end
  end
end
