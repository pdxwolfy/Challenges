#!/usr/bin/env ruby -w
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Prime
  def self.nth n_th
    raise ArgumentError, 'n_th must be >= 1' unless n_th >= 1
    Generator.new.nth(n_th)
  end

  # Helper class to generate prime numbers.
  class Generator
    def nth n_th
      @primes = [2, 3]
      return @primes[n_th - 1] if n_th <= 2

      @primes << next_prime until @primes.size == n_th
      @primes.last
    end

    private

    def next_prime
      number = @primes.last + 2
      number += 2 until prime? number
      number
    end

    def prime? number
      largest_possible_factor = Math.sqrt(number).to_i
      @primes.select { |prime| prime <= largest_possible_factor }
             .none?  { |prime| number % prime == 0 }
    end
  end
end
