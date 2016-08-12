# frozen_string_literal: true
# Copyright (c) 2016 Pete Hanson

class Trinary
  # Problem statement is such that we can't use String#to_i. However, even if
  # it were allowed, using this hash makes error detection easier.
  TO_I = { '0' => 0, '1' => 1, '2' => 2 }.freeze

  def initialize(trinary_number_string)
    @trinary_number = trinary_number_string
  end

  def to_decimal
    @trinary_number.each_char.inject(0) { |sum, digit| 3 * sum + TO_I[digit] }
  rescue TypeError
    0
  end
end
