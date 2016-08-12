#!/usr/bin/env ruby -w
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Fibonacci
  def self.nth n_th
    raise ArgumentError, 'n_th must be >= 1' unless n_th >= 1

    @fib = [1, 1]
    @fib.push @fib[-2] + @fib[-1] while @fib.size <= n_th
    @fib[n_th - 1]
  end
end

1.upto(10) { |number| puts Fibonacci.nth(number) }
puts Fibonacci.nth(10000)
puts Fibonacci.nth(100000)
