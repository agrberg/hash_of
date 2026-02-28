# frozen_string_literal: true

require_relative "hash_of/version"

# Module to contain the constants and class method Hash will extend
module HashOf
  OF_ARRAY_LAMBDA = ->(hash, key) { hash[key] = [] }
  OF_HASH_LAMBDA = ->(hash, key) { hash[key] = {} }
  OF_HASH_RECURSIVE_LAMBDA = ->(hash, key) { hash[key] = Hash.new(&hash.default_proc) }

  VALID_TYPES = %i[array hash].freeze

  def of(type, recursive: false)
    unless VALID_TYPES.include?(type)
      raise ArgumentError, "Invalid type: #{type.inspect}. Valid types are: #{VALID_TYPES.join(", ")}"
    end
    raise ArgumentError, "recursive is only supported with type: :hash" if recursive && type != :hash

    case type
    when :array
      Hash.new(&OF_ARRAY_LAMBDA)
    when :hash
      recursive ? Hash.new(&OF_HASH_RECURSIVE_LAMBDA) : Hash.new(&OF_HASH_LAMBDA)
    end
  end
end

Hash.extend(HashOf)
