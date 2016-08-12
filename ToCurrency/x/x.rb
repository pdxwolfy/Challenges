def to_currency(str)
  formatted_decimals = format "%.2f", str
  dollars, cents = formatted_decimals.split(".")
  dollars = dollars.reverse.scan(/.{3}|.+/).join(',').reverse
  "$#{dollars}.#{cents}"
end
