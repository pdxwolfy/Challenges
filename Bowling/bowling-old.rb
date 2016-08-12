#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

module Error
  MESSAGE = {
    bad_pin_count: 'Pins must have a value from 0 to 10',
    cannot_score:  'Score cannot be taken until the end of the game',
    too_many_pins: 'Pin count exceeds pins on the lane'
  }.freeze

  def self.invoke message_key
    raise MESSAGE[message_key]
  end
end

class Frame
  attr_reader :rolls

  def initialize
    @rolls = []
    @sum = 0
  end

  def << roll
    validate_pin_count roll

    @sum += roll
    @rolls << roll

    validate_total_pins
  end

  def complete?
    @rolls.size == 2 || strike?
  end

  def open?
    @rolls.size == 2 && @sum < Game::MAX_PIN_COUNT
  end

  def score next_2_frames
    all_rolls = rolls + expand(next_2_frames)
    total = all_rolls[0] + all_rolls[1]
    total += all_rolls[2] if total >= Game::MAX_PIN_COUNT
    total
  end

  def spare?
    @rolls.size == 2 && @sum == Game::MAX_PIN_COUNT
  end

  def strike?
    @rolls.size == 1 && @sum == Game::MAX_PIN_COUNT
  end

  private

  def expand frames
    frames.inject([]) { |rolls, frame| rolls.concat frame.rolls }
  end

  def validate_pin_count roll
    return if roll.between? 0, Game::MAX_PIN_COUNT

    Error.invoke(:bad_pin_count)
  end

  def valid_sum? rolls
    rolls.inject(0, :+) <= Game::MAX_PIN_COUNT
  end

  def validate_total_pins
    Error.invoke(:too_many_pins) unless valid_sum?(@rolls)
  end
end

class FinalFrame < Frame
  def initialize
    super
    @fill = []
  end

  def << roll
    validate_pin_count roll

    if @sum >= Game::MAX_PIN_COUNT
      @fill << roll
    else
      @rolls << roll
    end

    @sum += roll
    validate_total_pins
  end

  def complete?
    expected_roll_count = (@sum >= Game::MAX_PIN_COUNT) ? 3 : 2
    (@rolls.size + @fill.size) == expected_roll_count
  end

  def rolls
    @rolls + (@fills || [])
  end

  private

  def validate_total_pins
    super
    Error.invoke(:too_many_pins) unless valid_sum?(@fill)
  end
end

class Game
  MAX_PIN_COUNT = 10
  NUMBER_OF_FRAMES = 10

  def initialize
    @frames = []
    @current_frame = Frame.new
  end

  def roll pin_count
    @current_frame << pin_count
    return unless @current_frame.complete?

    @frames << @current_frame
    @current_frame = final_frame? ? FinalFrame.new : Frame.new
  end

  def score
    error(:cannot_score) unless game_complete?
    NUMBER_OF_FRAMES.times.inject 0 do |total_points, index|
      frame = @frames[index]
      total_points + frame.score(@frames[index + 1, 2])
    end
  end

  private

  def final_frame?
    @frames.size == NUMBER_OF_FRAMES - 1
  end

  def game_complete?
    @frames.size == NUMBER_OF_FRAMES && @frames.last.complete?
  end
end
