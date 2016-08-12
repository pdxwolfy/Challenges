#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Bst
  attr_reader :data

  def initialize new_data
    @data = new_data
    @leaves = { left: nil, right: nil }
  end

  def left
    @leaves[:left]
  end

  def right
    @leaves[:right]
  end

  def insert new_data
    leaf = (new_data <= data) ? :left : :right
    return if @leaves[leaf]&.insert new_data
    @leaves[leaf] = Bst.new new_data
  end

  def each &block
    return to_enum :each unless block_given?

    left.each(&block) if left
    yield @data
    right.each(&block) if right
  end
end
