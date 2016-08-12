#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Scrabble
  def initialize word
    @word = word.to_s.upcase
  end

  def score
    @word.each_char.inject(0) { |sum, letter| sum + points(letter) }
  end

  def self.score word
    new(word).score
  end

  private

  def points letter
    case letter
    when 'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T' then 1
    when 'D', 'G'                                         then 2
    when 'B', 'C', 'M', 'P'                               then 3
    when 'F', 'H', 'V', 'W', 'Y'                          then 4
    when 'K'                                              then 5
    when 'J', 'X'                                         then 8
    when 'Q', 'Z'                                         then 10
    else                                                       0
    end
  end
end
