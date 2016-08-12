# Pete Hanson
# Phone Number Challenge

class PhoneNumber
  BAD_NUMBER = '0000000000'

  attr_reader :number, :area_code

  def initialize(the_number)
    @number = strip(the_number) || BAD_NUMBER
    @area_code, @prefix, @suffix = parse @number
  end

  def to_s
    "(#{area_code}) #{@prefix}-#{@suffix}"
  end

  private # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def parse(the_number)
    # '1234567890' => ['', '123', '', '456', '7890'] = ['123', '456', '7890']
    the_number.split(/(...)/, 3).reject(&:empty?)
  end

  def strip(the_number)
    return if the_number =~ /[[:alpha:]]/i

    stripped = the_number.delete '^0-9'
    case stripped.size
    when 10 then stripped
    when 11 then stripped[1..-1] if stripped.start_with? '1'
    end
  end
end
