# Copyright (c) 2016 Pete Hanson
#
# frozen_string_literal: true

class Trinary
  TO_I = { '0' => 0, '1' => 1, '2' => 2 }.freeze # Can't use to_i

  def initialize(trinary_number_string)
    @trinary_number = trinary_number_string
  end

  def to_decimal
    @trinary_number.each_char.inject(0) { |sum, digit| 3 * sum + TO_I[digit] }
  rescue TypeError
    0
  end
end
