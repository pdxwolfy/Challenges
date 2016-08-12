#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Crypto
  attr_reader :normalize_plaintext, :size

  def initialize plaintext
    @normalize_plaintext = plaintext.downcase.delete '^a-z0-9'
    @size = Math.sqrt(normalize_plaintext.size).ceil
  end

  def ciphertext
    transpose.join
  end

  def normalize_ciphertext
    transpose.join ' '
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  private

  def fill_with_nils row
    row.concat [''] * (size - row.size)
  end

  def transpose
    matrix = plaintext_segments.map(&:chars)
    fill_with_nils matrix.last
    matrix.transpose.map(&:join)
  end
end
