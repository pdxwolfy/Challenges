class School
  attr_accessor :list
  def initialize
    @list = Hash.new{|hash,key| hash[key] = []}
  end

  def to_h
    return Hash[list.sort]
  end

  def add(name,grade)
    list[grade].push(name).sort!
  end

  def grade(grade)
    list[grade]
  end
end
