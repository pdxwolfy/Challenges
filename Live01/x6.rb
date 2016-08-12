# frozen_string_literal: true
#
# Copyright (c) 2016 Pete Hanson

require 'minitest/autorun'

def sorter(a, b)
  if a.start_with?(b)
    rest_of_a = a[b.size..-1]
    if rest_of_a.start_with?(b)
      sorter(rest_of_a, b)
    else
      rest_of_a <=> b
    end
  elsif b.start_with?(a)
    rest_of_b = b[a.size..-1]
    if rest_of_b.start_with?(a)
      sorter(a, rest_of_b)
    else
      a <=> rest_of_b
    end
  else
    a <=> b
  end
end

def lowest_number(number_list)
  number_list.map(&:to_s).sort { |a, b| sorter(a, b) }.join('').to_i
end

class TestLowestNumber < Minitest::Test
  def test_1
    assert_equal 1_23_550_80,       lowest_number([23, 550, 1, 80])
  end

  def test_2
    assert_equal 1_1_1_1,           lowest_number([1, 1, 1, 1])
  end

  def test_3
    assert_equal 10000_11_123_1890, lowest_number([10000, 123, 1890, 11])
  end

  def test_4
    assert_equal 1890_11890,        lowest_number([1890, 18901])
  end

  def test_5
    assert_equal 11_12_33_9,        lowest_number([12, 33, 11, 9])
  end

  def test_6
    assert_equal 18_1834_55023_550, lowest_number([55023, 550, 1834, 18])
  end

  def test_7
    assert_equal 1817_18_55023_550, lowest_number([55023, 550, 1817, 18])
  end

  def test_8
    assert_equal 1818_18_55023_550, lowest_number([55023, 550, 1818, 18])
  end

  def test_9
    assert_equal 1_1_1,             lowest_number([1, 1, 0, 1])
  end

  def test_10
    assert_equal 189018901_1890,    lowest_number([1890, 189018901])
  end

  def test_11
    assert_equal 18901890189018901_1890,
                 lowest_number([1890, 18901890189018901])
  end

  def test_12
    assert_equal 18901890189018901890189018902_189018901890189018901_1890_189,
                 lowest_number([1890, 189018901890189018901,
                                189,  18901890189018901890189018902])
  end
end
