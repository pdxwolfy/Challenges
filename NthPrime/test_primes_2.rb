#!/usr/bin/env ruby -w
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true
# :reek:FeatureEnvy
#
# Implementation details
#
# There is a result in number theory that states that:
#
#                            P(n)
#    ln(n) + ln(ln(n) - 1) < ---- < ln(n) + ln(ln(n))    for all n >= 6
#                              n
#
# where P(n) is the nth prime number. (NOTE: This result assumes that 1 is the
# first prime number.)
#
# Cf: https://en.wikipedia.org/wiki/Prime_number_theorem
#
# We will use this result to limit the range of numbers that must be checked as
# we attempt to generate the larger prime numbers.

# Class for storing previously calculated primes
class PrimeNumberGenerator
  def initialize
    @primes = [2]
  end

  def each_prime
    Enumerator.new do |yielder|
      yielder << 2
      loop { yielder << next_prime }
    end
  end

  private

  def next_prime
    number = lower_bound_of_next_prime
    number += 2 until prime? number
    @primes << number
    number
  end

  def prime? number
    largest_possible_factor = Math.sqrt(number).to_i
    @primes.select { |prime| prime <= largest_possible_factor }
           .none?  { |prime| number % prime == 0 }
  end

  def lower_bound_of_next_prime
    previous_prime = @primes.last

    case previous_prime
    when 2     then 3
    when 3..10 then previous_prime + 2 # 10 seems to be optimal
    else            compute_lower_bound @primes.size + 2, previous_prime
    end
  end

  def compute_lower_bound n_th, previous_prime
    log_n_th = Math.log n_th
    bound = (n_th * (Math.log(log_n_th) + Math.log(log_n_th - 1))).to_i
    bound += 1 if bound.even?
    [bound, previous_prime + 2].max
  end
end

# Driver module - we need a class because of conflicts with standard Prime
class Prime
  def self.nth n_th
    raise ArgumentError, 'n_th must be >= 1' unless n_th >= 1
    generator = PrimeNumberGenerator.new
    generator.each_prime.take(n_th).last
  end
end
