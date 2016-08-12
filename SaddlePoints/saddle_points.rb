#!/usr/bin/env ruby -w
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true
# :reek:FeatureEnvy

class Matrix
  attr_reader :rows

  def initialize(values)
    # Actually, this is a matrix
    @rows = values.split("\n").map { |line| make_row(line) }
  end

  def saddle_points
    @rows_max = select_in_each(rows, &:max)
    @columns_min = select_in_each(columns, &:min)
    rows.each_with_index.flat_map do |values, row|
      saddle_points_in_row(values, row)
    end
  end

  def columns
    rows.transpose
  end

  private

  def saddle_point?(row, column, value)
    value == @rows_max[row] && value == @columns_min[column]
  end

  def saddle_points_in_row(values, row)
    values.each_with_index.each_with_object([]) do |(value, column), list|
      list << [row, column] if saddle_point?(row, column, value)
    end
  end

  def make_row(line)
    line.split.inject([]) { |row, value| row << value.to_i }
  end

  def select_in_each(cells)
    cells.inject([]) { |list, cell| list << yield(cell) }
  end
end
