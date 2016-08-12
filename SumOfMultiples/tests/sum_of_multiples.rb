#!/usr/bin/env ruby
# Copyright (c) 2016 Launch School
# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../sum_of_multiples'

# Unit tests
class SumTest < Minitest::Test
  # :reek:UncommunicativeMethodName
  def test_sum_to_1
    assert_equal 0, SumOfMultiples.to(1)
  end

  # :reek:UncommunicativeMethodName
  def test_sum_to_3
    assert_equal 3, SumOfMultiples.to(4)
  end

  # :reek:UncommunicativeMethodName
  def test_sum_to_10
    assert_equal 23, SumOfMultiples.to(10)
  end

  # :reek:UncommunicativeMethodName
  def test_sum_to_100
    assert_equal 2_318, SumOfMultiples.to(100)
  end

  # :reek:UncommunicativeMethodName
  def test_sum_to_1000
    assert_equal 233_168, SumOfMultiples.to(1000)
  end

  # :reek:UncommunicativeMethodName
  def test_configurable_7_13_17_to_20
    assert_equal 51, SumOfMultiples.new(7, 13, 17).to(20)
  end

  # :reek:UncommunicativeMethodName
  def test_configurable_4_6_to_15
    assert_equal 30, SumOfMultiples.new(4, 6).to(15)
  end

  # :reek:UncommunicativeMethodName
  def test_configurable_5_6_8_to_150
    assert_equal 4419, SumOfMultiples.new(5, 6, 8).to(150)
  end

  # :reek:UncommunicativeMethodName
  def test_configurable_43_47_to_10000
    assert_equal 2_203_160, SumOfMultiples.new(43, 47).to(10_000)
  end

  # :reek:UncommunicativeMethodName
  def test_configurable_3_5_7_11_13_17_19_23_29_31_37_41_43_47_to_100_000_000
    primes = [3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
    expect = 3_612_950_751_460_358
    assert_equal expect, SumOfMultiples.new(*primes).to(100_000_000)
  end
end
