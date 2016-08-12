#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true


class Integer
  ROMAN_SYMBOLS = %w(I V X L C D M).freeze

  def to_roman
    reverse_digits.each_with_index.inject '' do |result, (digit, index)|
      digit_to_roman(digit, 2 * index) + result
    end
  end

  private

  def digit_to_roman digit, ones_position
    ones, fives, tens = ROMAN_SYMBOLS[ones_position, 3]

    case digit
    when 0    then ''
    when 1..3 then ones * digit
    when 4    then ones + fives
    when 5    then fives
    when 6..8 then fives + ones * (digit - 5)
    when 9    then ones + tens
    end
  end

  def reverse_digits
    to_s.chars.reverse.map(&:to_i)
  end
end
