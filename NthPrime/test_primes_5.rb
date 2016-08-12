#!/usr/bin/env ruby -w
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

# We use a class rather than a module because ruby won't let us create a module
# with the same name as an existing class. The alternative is to an ugly call
# to the private method Object#remove_const.
class Prime
  def self.nth n_th
    raise ArgumentError, 'n_th must be >= 1' unless n_th >= 1
    return n_th + 1 if [1, 2].include? n_th

    @factors = []
    @primes = [2, 3]
    @primes << next_prime until @primes.size == n_th
    @primes.last
  end

  def self.next_prime
    number = @primes.last + 2
    number += 2 until prime? number
    number
  end

  def self.prime? number
    factors = factors_to_check number
    factors.none? { |prime| number % prime == 0 }
  end

  def self.factors_to_check number
    largest_possible_factor = Math.sqrt(number + 0.01).to_i

    search_range = @factors.size...@primes.size
    search_range.each_with_object @factors do |index, factors|
      prime = @primes[index]
      break factors if prime > largest_possible_factor
      factors << prime
    end
  end
end
