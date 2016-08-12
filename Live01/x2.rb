# frozen_string_literal: true
#
# Copyright (c) 2016 Pete Hanson

def lowest_number(number_list)
  number_list.map(&:to_s).sort.join('').to_i
end

puts lowest_number([23, 550, 1, 80]) # -> 12355080
puts lowest_number([1, 1, 1, 1]) # -> 1111
puts lowest_number([10000, 123, 1890, 11]) # -> 10000111231890
puts lowest_number([1890, 18901]) # -> 189011890
puts lowest_number([12, 33, 11, 9]) # -> 1112339
