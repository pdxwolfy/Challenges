require 'set'
require 'singleton'

class Robot
  def name
    @name ||= Name.instance.generate
  end

  def reset
    @name = nil
  end
end

class Name
  include Singleton

  def initialize
    @names = Set.new
  end

  def generate
    name = unique_name
    @names.add name
    name
  end

  private

  def random_name
    ('AA'..'ZZ').to_a.sample + ('000'..'999').to_a.sample
  end

  def unique_name
    loop do
      name = random_name
      return name unless @names.include? name
    end
  end
end
