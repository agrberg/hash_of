# Hash.of

Mostly syntactic sugar to quickly and tersely create a hash of arrays or hashes, and optionally, recursive hashes.

If you find yourself doing `Hash.new { |hash, key] hash[key] = {} }` a lot you can make this more concise with `Hash.of(:hash)`.

It helps readability when iterating with `#reduce` or `#each_with_object` to create efficient lookup tables. E.g.:

```ruby
# This is a contrived example for illustrative purposes only as Rails' `Enumerable#index_by` is a better tool for the specific case being depicted.
a_buncha_records.each_with_object(Hash.new { |hash, key| hash[key] = {} }) do |record, cache|
  cache[record.id] = record
end

# vs.
a_buncha_records.each_with_object(Hash.of(:hash)) do |record, cache|
  cache[record.id] = record
end

# or go nuts and inline it
a_buncha_records.each_with_object(Hash.of(:hash)) { |record, cache| cache[record.id] = record }
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add hash_of

Alternatively add to your Gemfile via

    gem "hash_of", "~> 1.0"

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install hash_of


## Usage

Adds the `Hash.of` method providing the following uses

### 1. `Hash.of(:array)`

Returns a new hash whose unrecognized keys will be a new array.

```ruby
hash_of_arrays = Hash.of(:array)
hash_of_arrays[:any_key]
# => []
hash_of_arrays[:numbers_with_one] << 1
# => [1]
hash_of_arrays
# => {:any_key=>[], :numbers_with_one=>[1]}
```

### 2. `Hash.of(:hash)`

Returns a new hash whose unrecognized keys will be a new hash.

```ruby
hash_of_hashes = Hash.of(:hash)
hash_of_hashes[:any_key]
# => {}
hash_of_hashes[:names_and_numbers][:one]
# => nil
hash_of_hashes[:names_and_numbers][:one] = 1
# => 1
hash_of_hashes
# => {:any_key=>{}, :names_and_numbers=>{:one=>1}}
```

### 3. `Hash.of(:hash, recursive: true)`

Returns a hash where each unrecognized key is a hash where each unrecognized key is a hash … and so on.

```ruby
recursive_hash_of_hashes = Hash.of(:hash, recursive: true)
recursive_hash_of_hashes[:any_key]
# => {}
recursive_hash_of_hashes[:any_key][:and_another]
# => {}
recursive_hash_of_hashes[:any_key][:and_another][:one_more]
# => {}
recursive_hash_of_hashes[:any_key][:and_another][:one_more] = "abc"
# => "abc"
recursive_hash_of_hashes
# => {:any_key=>{:and_another=>{:one_more=>"abc"}}}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests and Rubocop. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hash_of.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
