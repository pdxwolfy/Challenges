#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

# This solution implements a singly linked list. The test suite and problem
# description are unclear when taken together

class Element
  attr_reader :datum, :next

  def initialize value, next_element = nil
    @datum = value
    @next = next_element
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  extend Forwardable

  def_delegators :@list, :empty?, :size
  def_delegator :@list, :last, :head
  def_delegator :@list, :first, :tail

  def self.from_a values
    values.to_a.reverse.each_with_object new do |datum, list|
      list.push datum
    end
  end

  def initialize
    @list = []
  end

  def peek
    head&.datum
  end

  def pop
    @list.pop.datum
  end

  def push datum
    @list.push Element.new(datum, head)
  end

  def reverse
    self.class.from_a to_a.reverse
  end

  def to_a
    @list.map(&:datum).reverse
  end
end
