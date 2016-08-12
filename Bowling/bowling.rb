#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class PrematureScoreError < RuntimeError
  def message
    'Score cannot be taken until the end of the game'
  end
end

class ExcessivePinCountError < RuntimeError
  def message
    'Pin count exceeds pins on the lane'
  end
end

class GameAlreadyOverError < RuntimeError
  def message
    'Should not be able to roll after game is over'
  end
end

class InvalidPinCountError < RuntimeError
  def message
    'Pins must have a value from 0 to 10'
  end
end

class Frame
  TOTAL_PINS = 10

  attr_reader :rolls

  def initialize
    @rolls = []
    @sum = 0
  end

  def << roll
    raise InvalidPinCountError unless pin_count.between? 0, TOTAL_PINS

    @rolls << roll
    @sum += roll

    raise ExcessivePinCountError unless @sum <= TOTAL_PINS
  end

  def mark?
    strike? || spare?
  end

  def open?
    @rolls.size == 2 && @sum < TOTAL_PINS
  end

  def score next_frame, following_frame
    rolls = @rolls + next_frame.rolls + following_frame.rolls
    rolls_to_count = mark? ? 3 : 2
    rolls.take(rolls_to_count).inject 0, :+
  end

  def size
    @rolls.size
  end

  def spare?
    @rolls.size == 2 && @sum == TOTAL_PINS
  end

  def strike?
    @rolls.size == 1 && @sum == TOTAL_PINS
  end
end

class Game
  TOTAL_FRAMES = 10

  def initialize
    @frames = []
    @current_frame = Frame.new
  end

  def roll pin_count
    raise GameAlreadyOverError if game_complete?

    @current_frame << pin_count
    next_frame if frame_complete?
  end

  def score
    raise PrematureScoreError unless game_complete?

    @frames << Frame.new until @frames.size == TOTAL_FRAMES + 2
    @frames.each_cons(3).inject 0 do |total_points, (frame1, frame2, frame3)|
      total_points + frame1.score(frame2, frame3)
    end
  end

  private

  def fill_frame?
    @frames.size >= TOTAL_FRAMES
  end

  def final_rolls # last regulation roll plus filler rolls
    @frames[TOTAL_FRAMES - 1, 3].flat_map(&:rolls)
  end

  def frame_complete?
    return true if fill_frame? && tenth_frame.size == 2
    @current_frame.size == 2 || @current_frame.strike?
  end

  def game_complete?
    case @frames.size
    when 0...TOTAL_FRAMES then false
    when TOTAL_FRAMES     then tenth_frame.open?
    else                       final_rolls.size == 3
    end
  end

  def next_frame
    @frames << @current_frame
    @current_frame = Frame.new
  end

  def tenth_frame
    @frames[TOTAL_FRAMES - 1]
  end
end
