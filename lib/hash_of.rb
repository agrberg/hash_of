# frozen_string_literal: true

require_relative "hash_of/version"

# Module to contain the constants, subclass, and class method Hash will extend
module HashOf
  OF_ARRAY_LAMBDA = ->(hash, key) { hash[key] = [] }
  OF_HASH_LAMBDA = ->(hash, key) { hash[key] = {} }
  OF_HASH_RECURSIVE_LAMBDA = ->(hash, key) { hash[key] = Hash.new(&hash.default_proc) }

  def of(type, recursive: false)
    case type
    when :array
      Hash.new(&OF_ARRAY_LAMBDA)
    when :hash
      recursive ? Hash.new(&OF_HASH_RECURSIVE_LAMBDA) : Hash.new(&OF_HASH_LAMBDA)
    end
  end
end

Hash.extend(HashOf)
