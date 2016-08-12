# Challenge of the Week: Grade School
# Pete Hanson
class School
  def add(student_name, grade_number)
    school[grade_number] += [student_name]
  end

  def grade(grade_number)
    school[grade_number].sort
  end

  def to_h
    school.keys.sort.each_with_object({}) do |grade, result|
      result[grade] = school[grade].sort
    end
  end

  #----------------------------------------------------------------------------
  private

  attr_accessor :school

  def initialize
    self.school = Hash.new([])
  end
end
