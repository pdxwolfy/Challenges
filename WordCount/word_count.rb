#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Phrase
  attr_reader :word_count

  def initialize phrase
    @word_count = Hash.new 0
    words(phrase).each_with_object @word_count do |word, word_hash|
      word_hash[word] += 1
    end
  end

  private

  def words phrase
    phrase.downcase.scan WORD_PATTERN
  end

  # words are composed entirely of letters or digits, possibly with some
  # apostrophes inside the word (but not at either end).
  WORD_PATTERN = /
    (?:                               # Don't capture anything!
      [a-z0-9][a-z0-9']*[a-z0-9]
      |
      [a-z0-9]+
    )
  /x
end
