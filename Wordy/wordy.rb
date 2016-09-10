#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true
# :reek:UnusedPrivateMethod: { exclude: %w(what plus minus multiplied divided) }

class WordProblem
  def initialize question
    @question = question
  end

  def answer
    tokenize.inject nil do |result, (operation, value_string)|
      die if value_string.nil?
      compute operation, result, Float(value_string)
    end
  end

  private

  OPERATIONS = {
    'plus'       => :+,
    'minus'      => :-,
    'multiplied' => :*,
    'divided'    => :/,
    'what'       => ->(_, value) { value } # initial value
  }.freeze

  IGNORED = %w(is by).freeze

  def compute operation, result, value
    action = OPERATIONS[operation]
    if action.respond_to? :call
      action.call result, value
    else
      result.__send__ action, value
    end
  end

  def die
    raise ArgumentError, 'Cannot compute result.'
  end

  # Returns iterator to list of operation/value token pairs
  def tokenize
    tokens = @question.downcase.chomp('?').split
    useful_tokens = tokens.reject { |token| IGNORED.include? token }
    useful_tokens.each_slice 2
  end
end

puts WordProblem.new('What is 3 plus 3?').answer
