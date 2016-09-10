#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

# Generate "beer on the wall verses"
class BeerSong
  # Handle no bottles of beer verse
  class NoBottles
    def verse _
      <<~VERSE
        No more bottles of beer on the wall, no more bottles of beer.
        Go to the store and buy some more, 99 bottles of beer on the wall.
      VERSE
    end
  end

  # Handle one bottle of beer verse
  class OneBottle
    def verse _
      <<~VERSE
        1 bottle of beer on the wall, 1 bottle of beer.
        Take it down and pass it around, no more bottles of beer on the wall.
      VERSE
    end
  end

  # Handle two bottles of beer verse
  class TwoBottles
    def verse _
      <<~VERSE
        2 bottles of beer on the wall, 2 bottles of beer.
        Take one down and pass it around, 1 bottle of beer on the wall.
      VERSE
    end
  end

  # Handle all other verses
  class NBottles
    def verse number
      left = number - 1

      <<~VERSE
        #{number} bottles of beer on the wall, #{number} bottles of beer.
        Take one down and pass it around, #{left} bottles of beer on the wall.
      VERSE
    end
  end

  BOTTLES_CLASSES = [NoBottles, OneBottle, TwoBottles].freeze

  def verse number
    bottles_class = BOTTLES_CLASSES.fetch number, NBottles
    bottles_class.new.verse number
  end

  def lyrics
    verses 99, 0
  end

  def verses first_verse, last_verse
    first_verse.downto(last_verse).map { |number| verse number }.join "\n"
  end
end
