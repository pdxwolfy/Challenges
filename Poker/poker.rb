#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

# Represents a card including its value relative to other cards.
class Card
  include Comparable

  VALUES = { 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }.freeze

  attr_reader :rank, :suit, :value

  def initialize name
    @name = name
    @rank, @suit = name.chars
    @value = VALUES.fetch @rank, @rank.to_i
  end

  def <=> other
    @value <=> other.value if other
  end

  def to_s
    @name
  end
end

# Hand ranking methods
module HandRanking
  @public_methods = []

  def self.public_methods
    @public_methods
  end

  def self.method_added method_name
    @public_methods << method_name
  end

  # All of the remaining methods get added to @public_methods in the sequence in
  # which they are defined. Higher ranking hands should be first, lower ranking
  # hands last

  def royal_flush?
    straight_flush? && sequence == %w(T J Q K A)
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    n_of_a_kind? 4
  end

  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def flush?
    @suit_counts.any? { |_, count| count == 5 }
  end

  def straight?
    sequence
  end

  def three_of_a_kind?
    n_of_a_kind? 3
  end

  def two_pair?
    @rank_counts.select { |_, count| count == 2 }.size == 2
  end

  def pair?
    n_of_a_kind? 2
  end

  def nothing?
    true
  end
end

# Represents a poker hand consisting of 5 cards
class Hand
  include Comparable
  include HandRanking

  def initialize cards
    @cards = cards.map { |name| Card.new name }
    @rank_counts = count_cards_by :rank
    @suit_counts = count_cards_by :suit
  end

  def to_a
    @cards.map(&:to_s)
  end

  protected

  # The best hand is the highest ranking hand according to the rules of poker.
  def <=> other
    return unless other

    my_hand = [-hand_ranking, high_card]
    other_hand = [-other.hand_ranking, other.high_card]
    my_hand <=> other_hand
  end

  # The high card is the rank that occurs most often in the hand. If there are
  # multiple such cards, then the highest rank amongst the candidates is chosen.
  # PROBLEM: We only check one card to see if it is the high card.
  def high_card
    @cards.sort_by { |card| [@rank_counts[card.rank], card] }.last
  end

  # Returns relative ranking of hands (0 is highest, + is lower)
  def hand_ranking
    hand_type_methods = HandRanking.public_methods
    hand_type_methods.each_with_index do |hand_type, ranking|
      break ranking if __send__ hand_type
    end
  end

  private

  def count_cards_by component
    @cards.each_with_object Hash.new(0) do |card, count|
      value = card.public_send component
      count[value] += 1
    end
  end

  def n_of_a_kind? number
    @rank_counts.one? { |_, count| count == number }
  end

  def sequence
    %w(A 2 3 4 5 6 7 8 9 T J Q K A).each_cons 5 do |cons|
      return cons if @rank_counts.values_at(*cons) == [1, 1, 1, 1, 1]
    end
    nil
  end
end

# Represents several poker hands.
class Poker
  def initialize hands
    @hands = hands.map { |cards| Hand.new cards }
  end

  def best_hand
    max_hand = @hands.max
    best_hands = @hands.select { |hand| hand == max_hand }
    best_hands.map(&:to_a)
  end
end
