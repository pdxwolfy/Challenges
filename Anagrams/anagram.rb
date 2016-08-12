#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

# class Anagram
#   def initialize word
#     @original_word = word
#     @letters = letters @original_word
#   end
#
#   def match possibilities
#     possibilities.sort.select { |word| anagram? word }
#   end
#
#   private
#
#   def anagram? word
#     @letters == letters(word) && @original_word != word.downcase
#   end
#
#   def letters word
#     word.downcase.chars.sort
#   end
# end

class Anagram
  def initialize word
    @original_word = word
    @letters = letters @original_word
  end

  def match possibilities
    possibilities.sort.select { |word| anagram? word }
  end

  private

  def anagram? word
    @letters == letters(word) && @original_word != word.downcase
  end

  def letters word
    word.downcase.chars.each_with_object(Hash.new 0) do |char, hash|
      hash[char] += 1
    end
  end
end
