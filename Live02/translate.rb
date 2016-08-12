require 'pry'

CONSONANTS = %w(b c d f g h j k l m n p q r s t v w x y z)

def translate! text
  index = text.size - 1
  while index >= 0
    if CONSONANTS.include?(text[index].downcase)
      text[index, 1] = text[index] + 'o' + text[index]
    end
    index -= 1
  end
end

x = 'this is fun'
translate! x
puts x
