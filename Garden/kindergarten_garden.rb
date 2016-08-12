#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class Garden
  PLANTS = {
    'C' => :clover,
    'G' => :grass,
    'R' => :radishes,
    'V' => :violets
  }.freeze

  DEFAULT_STUDENTS = %w(Alice Bob Charlie David
                        Eve Fred Ginny Harriet
                        Ileana Joseph Kincaid Larry).freeze

  def initialize plants, students = DEFAULT_STUDENTS
    @cups = Hash.new { |hash, key| hash[key] = [] }
    @students = students.sort
    plant plants
    define_student_methods
  end

  private

  def define_student_methods
    @students.each do |student|
      define_singleton_method(student.downcase) { @cups[student] }
    end
  end

  def plant plants
    plants.split("\n").each { |row| plant_row row }
  end

  def plant_row row
    plants = row.chars.map { |plant_key| PLANTS[plant_key] }
    plants.each_slice(2).with_index do |(left_plant, right_plant), index|
      student = @students[index]
      @cups[student].push left_plant, right_plant
    end
  end
end
