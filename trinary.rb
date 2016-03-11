class Trinary
  def initialize(trinary_number_string)
    @trinary_number = trinary_number_string
  end

  def to_decimal
    return 0 unless @trinary_number =~ /\A[012]+\Z/
    @trinary_number.chars.inject(0) { |memo, digit| 3 * memo + digit.to_i }
  end
end
