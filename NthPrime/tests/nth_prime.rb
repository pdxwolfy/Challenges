#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

require 'prime'

ERROR_MESSAGE = <<-MSG
Using Ruby's Prime class is probably the best way to do this in a
'real' application; but this is an exercise, not a real application,
so you're expected to implement this yourself.
MSG

class Prime
  %i(each new prime? take).each do |method|
    define_method(method) { |*_| raise ERROR_MESSAGE }
  end
end

class Integer
  %i(prime? each_prime).each do |method|
    define_method(method) { |*_| raise ERROR_MESSAGE }
  end
end

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../nth_prime'

# Our unit tests
class TestPrimes < Minitest::Test
  def test_first
    assert_equal 2, Prime.nth(1)
  end

  def test_second
    assert_equal 3, Prime.nth(2)
  end

  def test_sixth_prime
    assert_equal 13, Prime.nth(6)
  end

  def test_big_prime
    assert_equal 104_743, Prime.nth(10_001)
  end

  def test_huge_prime
    assert_equal 1_299_709, Prime.nth(100_000)
  end

  def test_really_huge_prime
    skip
    assert_equal 15_485_863, Prime.nth(1_000_000)
  end

  def test_weird_case
    assert_raises ArgumentError do
      Prime.nth(0)
    end
  end
end
