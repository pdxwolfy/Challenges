# frozen_string_literal: true
#
# Copyright (c) 2016 Pete Hanson

def lowest_number(number_list)
  number_list.map(&:to_s)
             .permutation
             .map(&:join)
             .map(&:to_i)
             .min
end

def assert(expect, actual)
	return if expect == actual
	fail "#{expect} != #{actual}"
end

assert 1_23_550_80,       lowest_number([23, 550, 1, 80])
assert 1_1_1_1,           lowest_number([1, 1, 1, 1])
assert 10000_11_123_1890, lowest_number([10000, 123, 1890, 11])
assert 1890_11890,        lowest_number([1890, 18901])
assert 11_12_33_9,        lowest_number([12, 33, 11, 9])
assert 18_1834_55023_550, lowest_number([55023, 550, 1834, 18])
assert 1_1_1,             lowest_number([1, 1, 0, 1])
