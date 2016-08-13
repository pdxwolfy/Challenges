#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

module Bookkeeping
  VERSION = 1
end

# This is my original code. It's concise and rubyesque, but I don't think it's
# particularly easy to follow.
module DiamondOriginal
  def self.make_diamond last_letter
    other_letters = ('A'...last_letter).to_a
    letters = other_letters + [last_letter] + other_letters.reverse
    rows = letters.map { |letter| formatted_row letter, letters.size }
    rows.join
  end

  def self.formatted_row letter, width
    spacing = 2 * (letter.ord - 'A'.ord)
    content = spacing.zero? ? letter : "#{letter}#{letter.rjust spacing}"
    "#{content.center width}\n"
  end
end

# Final code. More verbose, but I think it's clearer. Most interestingly,
# there is no edge case processing required.
class Diamond
  def self.make_diamond last_letter
    diamond = Diamond.new last_letter
    diamond.build
  end

  def initialize last_letter
    @last_letter = last_letter
    @size = 2 * index_of(@last_letter) + 1
    @rows = Array.new(@size) { ' ' * @size + "\n" }
  end

  def index_of letter
    letter.ord - 'A'.ord
  end

  def build
    ('A'..@last_letter).each { |letter| add_to_display letter }
    @rows.join
  end

  def add_to_display letter
    index = index_of letter

    center = (@size - 1) / 2
    @rows[index][center - index] = letter
    @rows[index][center + index] = letter
    @rows[@size - (index + 1)][center - index] = letter
    @rows[@size - (index + 1)][center + index] = letter
  end
end
