# frozen_string_literal: true
#
# Copyright (c) 2016 Pete Hanson

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'x'

# Unit tests
# :reek:UncommunicativeMethodName
class XTest < Minitest::Test
  def test_trinary_1_is_decimal_1
    assert_equal 1, Trinary.new('1').to_decimal
  end
end
