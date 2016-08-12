# frozen_string_literal: true
#
# Copyright (c) 2016 Pete Hanson

def smash(string)
	string.gsub(/[^a-z]/i, '').chars.join ' '
end

puts smash('Hello, world!') # -> H e l l o w o r l d
puts smash('')
puts smash('!')
puts smash('a')
puts smash('abc')
