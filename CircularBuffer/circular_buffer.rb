# Challenge of the Week: Circular Buffer
# Pete Hanson
class CircularBuffer
  class BufferEmptyException < RuntimeError; end
  class BufferFullException < RuntimeError; end

  def clear
    initialize(buffer.size)
  end

  def read
    fail(BufferEmptyException) if empty?
    result = buffer[read_index]
    self.read_index = add_at_index(nil, read_index)
    result
  end

  def write(value)
    add_to_buffer(value) { fail(BufferFullException) }
  end

  def write!(value)
    add_to_buffer(value) { read }
  end

private

  attr_accessor :buffer, :read_index, :write_index

  def initialize(number_of_cells)
    self.buffer = Array.new(number_of_cells)
    @read_index = @write_index = 0
  end

  def add_at_index(value, index)
    buffer[index] = value
    advance(index)
  end

  def add_to_buffer(value) # optional block is called when buffer.full?
    return if value.nil?
    yield if block_given? && full?
    self.write_index = add_at_index(value, write_index)
  end

  def advance(pointer)
    pointer += 1
    (pointer == buffer.size) ? 0 : pointer
  end

  def empty?
    buffer.all?(&:nil?)
  end

  def full?
    buffer.none?(&:nil?)
  end
end
