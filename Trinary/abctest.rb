#!/usr/bin/env ruby -w

require 'minitest/autorun'
require_relative 'abc'

class TestIt < Minitest::Test
  def test_go
    Abc.new.xyz
  end
end

exit 0
