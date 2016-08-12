#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true
# :reek:FeatureEnvy

class Triangle
  attr_reader :rows

  def initialize height
    @rows = (1..height).map { next_row }
  end

  private

  def next_row
    bottom_row = @previous_row ? [0, *@previous_row, 0] : [0, 1]
    @previous_row = bottom_row.each_cons(2).map { |left, right| left + right }
  end
end

# class Triangle
#   attr_reader :rows
#
#   def initialize height
#     factorial = [1]
#     1.upto(height).each { |n| factorial << n * factorial.last }
#
#     @rows = 0.upto(height - 1).map do |row|
#       0.upto(row).map do |seq|
#         factorial[row] / (factorial[seq] * factorial[row - seq])
#       end
#     end
#   end
# end
#
# puts Triangle.new(500).rows.last
