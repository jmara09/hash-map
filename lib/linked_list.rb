require_relative 'node'

class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    @new_node = Node.new(value)
    @size += 1
    if @size == 1
      @tail = @new_node
      @head = @new_node
    else
      @tail.next_node = @new_node
      @tail = @new_node
    end
  end

  def prepend(value)
    @new_node = Node.new(value, @head)
    @head = @new_node
    @size += 1
    @tail = @new_node if @size == 1
  end

  def at(index)
    return @head if index.zero?

    @count = 0
    @node = head

    loop do
      @node = @node.next_node
      @count += 1
      return @node if @count == index
      break puts 'Not found' if @count > index
    end
  end

  def pop
    @node = head
    if @node.next_node.nil?
      @head = nil
      @tail = nil
      @size -= 1
    end

    loop do
      if @node.next_node.next_node.nil?
        @node.next_node = nil
        @tail = @node
        @size -= 1
        break
      else
        @node = @node.next_node
      end
    end
  end

  def contains?(value)
    @node = head

    loop do
      if @node.value == value
        return true
      elsif @node.next_node.nil?
        return false
      else
        @node = @node.next_node
      end
    end
  end

  def find(value)
    @node = head
    @count = 0
    loop do
      if @node.value.key?(value)
        return @count
      elsif @node.next_node.nil?
        return nil
      else
        @node = @node.next_node
        @count += 1
      end
    end
  end

  def length
    @node = head
    @count = @node.nil? ? 0 : 1
    loop do
      return @count if @node.next_node.nil? || @count.zero?

      @node = @node.next_node
      @count += 1
    end
  end

  def to_s
    @node = head
    string = ''

    loop do
      break if @node.nil?

      string += "( #{@node.value} ) -> "
      @node = @node.next_node
    end
    string += 'nil'
    string
  end

  def insert_at(value, index)
    @node = head
    @count = 0
    loop do
      if index.zero?
        break prepend(value)
      elsif index == @count + 1
        @node.next_node = Node.new(value, @node.next_node)
        @size += 1
        break
      else
        @count += 1
        @node = @node.next_node
      end
      break if @node.nil?
    end
  end

  def remove_at(index)
    @node = head
    @count = 0
    @deleted_value = nil
    return puts 'Invalid index' if index >= size

    loop do
      if index.zero?
        @deleted_value = head.value.values
        @head = @head.next_node
        break
      elsif index == @count + 1
        @deleted_value =  @node.next_node.value.values
        @node.next_node = @node.next_node.next_node
        break
      else
        @count += 1
        @node = @node.next_node
      end
    end
    @size -= 1
    @tail = @node if @node.next_node.nil?
    @deleted_value
  end
end
