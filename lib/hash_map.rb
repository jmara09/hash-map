require_relative 'linked_list'

class HashMap
  attr_reader :buckets

  def initialize
    @buckets = Array.new(16, nil)
    @load_factor = 0.75
  end

  def index(key)
    hash(key) % @buckets.length
  end

  def hash(key)
    @hash_code = 0
    @prime_number = 31

    key.each_char { |char| @hash_code = (@prime_number * @hash_code) + char.ord }

    @hash_code
  end

  def set(key, value)
    @data = { key => value }
    @index = index(key)
    if has?(key)
      puts @buckets[@index].at(@buckets[@index].find(key)).value = @data
    else
      @buckets[@index] = LinkedList.new if @buckets[@index].nil?
      @buckets[@index].append(@data)
    end

    return unless length > load_factor

    @pairs = entries
    @buckets = Array.new(@buckets.length * 2, nil)
    @pairs.each do |pair|
      set(pair[0], pair[1])
    end
  end

  def load_factor
    @buckets.length * @load_factor
  end

  def get(key)
    @index = index(key)
    if @buckets[@index].nil?
      nil
    else
      @buckets[@index].at(@buckets[@index].find(key)).value.values
    end
  end

  def has?(key)
    @index = index(key)
    return false if @buckets[@index].nil?

    if @buckets[@index].find(key)
      true
    else
      false
    end
  end

  def remove(key)
    @index = index(key)
    return 'Not found' unless has?(key)

    @buckets[@index].remove_at(@buckets[@index].find(key))
  end

  def length
    @buckets.reduce(0) do |count, bucket|
      next count if bucket.nil?

      count + bucket.length
    end
  end

  def clear
    @buckets.map! { |_| nil }
  end

  def keys
    @buckets.reduce([]) do |array, bucket|
      next array if bucket.nil?

      bucket = bucket.head

      loop do
        break array if bucket.nil?

        array << bucket.value.keys.join
        bucket = bucket.next_node
      end
    end
  end

  def values
    @buckets.reduce([]) do |array, bucket|
      next array if bucket.nil?

      bucket = bucket.head

      loop do
        break array if bucket.nil?

        array << bucket.value.values.join
        bucket = bucket.next_node
      end
    end
  end

  def entries
    @buckets.reduce([]) do |array, bucket|
      next array if bucket.nil?

      bucket = bucket.head

      loop do
        break array if bucket.nil?

        array << [bucket.value.keys.join, bucket.value.values.join]
        bucket = bucket.next_node
      end
    end
  end
end
