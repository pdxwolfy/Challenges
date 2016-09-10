#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Cipher
  attr_reader :key

  LETTERS = ('a'..'z').to_a
  ENCODE = +1
  DECODE = -1

  def initialize key = nil
    @key = key || random_key

    message = 'Key is limited to lowercase letters'
    raise ArgumentError, message unless @key =~ /\A[a-z]+\z/
  end

  def decode cipher_text
    translate cipher_text, DECODE
  end

  def encode plain_text
    translate plain_text, ENCODE
  end

  private

  def random_key
    Array.new(100) { LETTERS.sample }.join
  end

  def shift_by index
    @key[index % @key.size].ord - 'a'.ord
  end

  def shift_char char, index, direction
    shift_amount = shift_by index
    new_char = (char.ord + direction * shift_amount).chr
    return new_char if LETTERS.include? new_char

    (new_char.ord - LETTERS.size * direction).chr
  end

  def translate text, direction
    text.each_char.with_index.reduce '' do |result, (char, index)|
      result + shift_char(char, index, direction)
    end
  end
end
