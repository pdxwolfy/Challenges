#!/usr/bin/env ruby
# Copyright (c) 2016 Launch School
# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../find_largest_product'

# Unit tests
class FindLargestMultipleTest < Minitest::Test
  def test_1_digit
    seq = SequenceProducts.new(NUMBER, 1).largest_product
    prod = SequenceProducts.product seq
    assert_equal [9], seq
    assert_equal 9, prod
  end

  def test_2_digits
    seq = SequenceProducts.new(NUMBER, 2).largest_product
    prod = SequenceProducts.product seq
    assert_equal [9, 9], seq
    assert_equal 81, prod
  end

  def test_3_digits
    seq = SequenceProducts.new(NUMBER, 3).largest_product
    prod = SequenceProducts.product seq
    assert_equal [9, 8, 9], seq
    assert_equal 648, prod
  end

  def test_4_digits
    seq = SequenceProducts.new(NUMBER, 4).largest_product
    prod = SequenceProducts.product seq
    assert_equal [9, 9, 8, 9], seq
    assert_equal 5832, prod
  end

  def test_13_digits
    seq = SequenceProducts.new(NUMBER, 13).largest_product
    prod = SequenceProducts.product seq
    assert_equal [5, 5, 7, 6, 6, 8, 9, 6, 6, 4, 8, 9, 5], seq
    assert_equal 23_514_624_000, prod
  end
end
