# frozen_string_literal: true
#
# Copyright (c) 2016 Pete Hanson

class Hex
  HEX_TO_I = { 'a' => 10, 'b' => 11, 'c' => 12,
               'd' => 13, 'e' => 14, 'f' => 15 }.freeze

  def initialize(hex_number_string)
    @hex_number = hex_number_string
  end

  def to_decimal
    @hex_number.each_char.inject(0) do |sum, hex_digit|
      16 * sum + to_int(hex_digit)
    end
  rescue TypeError
    0
  end

  def to_int(hex_digit)
    return hex_digit.to_i if ('0'..'9').cover?(hex_digit)
    HEX_TO_I[hex_digit.downcase]
  end
end
