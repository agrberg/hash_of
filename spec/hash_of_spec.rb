# frozen_string_literal: true

RSpec.describe HashOf do
  it "has a version number" do
    expect(HashOf::VERSION).not_to be_nil
  end

  describe "extending Hash to provide Hash.of" do
    it "provides a hash where each unrecognized key is another hash", :aggregate_failures do
      hash_of_hashes = Hash.of(:hash)

      expect(hash_of_hashes[:some_key]).to be_a(Hash)
      expect(hash_of_hashes[:some_key][:another_key]).to be_nil
    end

    it "provides a hash where each unrecognized key is an array", :aggregate_failures do
      hash_of_arrays = Hash.of(:array)

      expect(hash_of_arrays[:some_key]).to be_a(Array)
      expect(hash_of_arrays[:some_key][0]).to be_nil
    end

    context "when recursive" do
      it "provides a hash where each unrecognized key is another hash all the way down", :aggregate_failures do
        hash_of_hashes = Hash.of(:hash, recursive: true)

        expect(hash_of_hashes[:some_key]).to be_a(Hash)
        expect(hash_of_hashes[:some_key][:another_key]).to be_a(Hash)
        expect(hash_of_hashes[:some_key][:another_key][:keep_going]).to be_a(Hash)
      end
    end
  end
end
