#!/usr/bin/env ruby -w
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

# We use a class rather than a module because ruby won't let us create a module
# with the same name as an existing class. The alternative is to an ugly call
# to the private method Object#remove_const.
class Prime
  def self.nth n_th
    raise ArgumentError, 'n_th must be >= 1' unless n_th >= 1

    if [1, 2].include? n_th
      n_th + 1
    else
      @primes = [2, 3]
      @primes << next_prime until @primes.size == n_th
      @primes.last
    end
  end

  def self.next_prime
    number = @primes.last + 2
    number += 2 until prime? number
    number
  end

  def self.prime? number
    largest_possible_factor = Math.sqrt(number + 0.01).to_i
    @primes.take_while { |prime| prime <= largest_possible_factor }
           .none?      { |prime| number % prime == 0 }
  end
end
