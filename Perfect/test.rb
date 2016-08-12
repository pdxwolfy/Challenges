#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

require_relative 'perfect_numbers'

class PerfectNumberTest < Minitest::Test
  def test_initialize_perfect_number
    assert_raises RuntimeError do
      PerfectNumber.classify(-1)
    end
  end

  def test_classify_deficient
    assert_equal 'deficient', PerfectNumber.classify(13)
  end

  def test_classify_perfect
    assert_equal 'perfect', PerfectNumber.classify(28)
  end

  def test_classify_abundant
    assert_equal 'abundant', PerfectNumber.classify(12)
  end

  def test_classify_big
    assert_equal 'perfect', PerfectNumber.classify(8128)
    assert_equal 'deficient', PerfectNumber.classify(8127)
  end
end
