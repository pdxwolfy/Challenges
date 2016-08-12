COMMAIZE = %r{
  (\d)      # need at least one digit before each group of 3
  (\d\d\d)  # 3 digits in a row
  (\D)      # decimal point or comma
}x

def to_currency amount_as_string
  rounded_amount = round_float_as_string amount_as_string
  amount_with_commas = insert_commas! rounded_amount
  "$#{amount_with_commas}"
end

def round_float_as_string value
  format '%.2f', Float(value).round(2)
end

def insert_commas! amount_as_string
  while amount_as_string.sub! COMMAIZE, '\1,\2\3'; end
  amount_as_string
end
