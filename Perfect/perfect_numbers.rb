#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

require 'prime'

module PerfectNumber
  def self.classify number
    raise 'Number must be positive' unless number > 0
    raise 'Number must be an integer' unless number.to_i == number

    case sum_of_divisors(number) <=> number
    when -1 then 'deficient'
    when  0 then 'perfect'
    when  1 then 'abundant'
    end
  end

  def self.sum_of_divisors number
    divisors(number).inject(:+) - number
  end

  def self.divisors number
    prime_factorization(number).inject [1] do |divisors, factor_list|
      divisors.product(factor_list).map { |value1, value2| value1 * value2 }
    end
  end

  # Returns Array of nested Arrays. Each nested array is a list of all powers of
  # a prime number that are factors of number.
  #     prime_factorization(72) == [[1, 2, 4, 8], [1, 3, 9]]
  def self.prime_factorization number
    prime_factors = Prime.prime_division number
    prime_factors.each_with_object [] do |(prime, max_power), factor_lists|
      factor_lists << 0.upto(max_power).map { |power| prime**power }
    end
  end
end

# puts Benchmark.measure { puts PerfectNumber.classify 13 }
# puts Benchmark.measure { puts PerfectNumber.classify 28 }
# puts Benchmark.measure { puts PerfectNumber.classify 12 }
# puts Benchmark.measure { puts PerfectNumber.classify 8128 }
# puts Benchmark.measure { puts PerfectNumber.classify 8127 }
# puts Benchmark.measure { puts PerfectNumber.classify 999_999 }
# puts Benchmark.measure { puts PerfectNumber.classify 999_999_999 }
# puts Benchmark.measure { puts PerfectNumber.classify 999_999_999_999 }
# puts Benchmark.measure { puts PerfectNumber.classify 999_999_999_999_999 }
puts Benchmark.measure { puts PerfectNumber.classify 999_999_999_999_999_999 }.inspect
