# frozen_string_literal: true

RSpec.describe HashOf do
  it "has a version number" do
    expect(HashOf::VERSION).not_to be_nil
  end

  describe "extending Hash to provide Hash.of" do
    describe "Hash.of(:hash)" do
      it "returns a Hash" do
        expect(Hash.of(:hash)).to be_a(Hash)
      end

      it "auto-vivifies missing keys as empty hashes" do
        hash = Hash.of(:hash)

        expect(hash[:missing]).to be_a(Hash)
      end

      it "persists auto-vivified keys" do
        hash = Hash.of(:hash)
        hash[:a]

        expect(hash).to have_key(:a)
      end

      it "does not recurse by default" do
        hash = Hash.of(:hash)

        expect(hash[:a][:b]).to be_nil
      end

      it "supports nested assignment" do
        hash = Hash.of(:hash)
        hash[:users][:name] = "Alice"

        expect(hash[:users][:name]).to eq("Alice")
      end
    end

    describe "Hash.of(:array)" do
      it "returns a Hash" do
        expect(Hash.of(:array)).to be_a(Hash)
      end

      it "auto-vivifies missing keys as empty arrays" do
        hash = Hash.of(:array)

        expect(hash[:missing]).to be_a(Array)
      end

      it "persists auto-vivified keys" do
        hash = Hash.of(:array)
        hash[:a]

        expect(hash).to have_key(:a)
      end

      it "supports appending to arrays" do
        hash = Hash.of(:array)
        hash[:fruits] << "apple"
        hash[:fruits] << "banana"

        expect(hash[:fruits]).to eq(%w[apple banana])
      end
    end

    describe "Hash.of(:hash, recursive: true)" do
      it "auto-vivifies nested keys as hashes all the way down", :aggregate_failures do
        hash = Hash.of(:hash, recursive: true)

        expect(hash[:a]).to be_a(Hash)
        expect(hash[:a][:b]).to be_a(Hash)
        expect(hash[:a][:b][:c]).to be_a(Hash)
      end

      it "supports deep nested assignment" do
        hash = Hash.of(:hash, recursive: true)
        hash[:a][:b][:c] = "deep"

        expect(hash[:a][:b][:c]).to eq("deep")
      end
    end

    describe "argument validation" do
      it "raises ArgumentError for invalid types" do
        expect { Hash.of(:string) }.to raise_error(ArgumentError, /Invalid type: :string/)
      end

      it "raises ArgumentError for recursive with :array" do
        expect { Hash.of(:array, recursive: true) }.to raise_error(ArgumentError, /recursive is only supported/)
      end
    end
  end
end
