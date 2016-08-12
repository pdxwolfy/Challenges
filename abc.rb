require 'pry'

class Abc
  def abc
    puts 'hello'
  end

  def xyz
    binding.pry
    abc
    puts 'bye'
  end
end
