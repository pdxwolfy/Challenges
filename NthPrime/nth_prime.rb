#!/usr/bin/env ruby -w
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Prime
  def self.nth n_th
    raise ArgumentError, 'n_th must be >= 1' unless n_th >= 1
    return 2 if n_th == 1

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
    max = Math.sqrt(number)
    @primes.lazy.none? do
      break true if prime > max
      number % prime == 0
    end
  end
end
