# frozen_string_literal: true

require_relative "hash_of/version"

# Module to contain the constants, subclass, and class method Hash will extend
module HashOf
  OF_ARRAY_LAMBDA = ->(hash, key) { hash[key] = [] }
  OF_HASH_LAMBDA = ->(hash, key) { hash[key] = {} }

  # Produce new Hashes with their default proc set to create hashes recursively
  class OfHash < Hash
    def initialize = super { |hash, key| hash[key] = OfHash.new }
  end

  def of(type, recursive: false)
    case type
    when :array
      Hash.new(&OF_ARRAY_LAMBDA)
    when :hash
      recursive ? OfHash.new : Hash.new(&OF_HASH_LAMBDA)
    end
  end
end

Hash.extend(HashOf)
