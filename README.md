# Hash.of

Syntactic sugar to tersely create a hash of arrays or hashes, and optionally, recursive hashes.

While clear, creating a hash of hashes via `Hash.new { |hash, key| hash[key] = {} }` is verbose. If this pattern is common in your codebase you can express it more concisely as `Hash.of(:hash)`. This can help readability when iterating with `#reduce` or `#each_with_object` to create efficient lookup tables.

## Example

We have a bunch of records containing the winners of the Academy Awards. We'd like to provide a simple interface for people to look up winners by year and category like the following:

```ruby
winners_by_year_by_category[2024][:best_picture]
# => "Oppenheimer
```

Let's say we have `AcademyAwardResult` objects which have the properties `year`, `category`, and `winner`. They may look something like:

```ruby
[
  #<AcademyAwardResult year=2024, category=:best_picture, winner="Oppenheimer">,
  #<AcademyAwardResult year=2024, category=:best_actor, winner="Cillian Murphy">,
  …
  #<AcademyAwardResult year=2023, category=:best_picture, winner="Everything Everywhere All at Once">,
  …
  #<AcademyAwardResult year=2022, category=:best_picture, winner="CODA">
]
```

The following turns this array of records into a lookup table:

```ruby
award_results.each_with_object(Hash.new { |hash, key| hash[key] = {} }) do |result, lookup|
  lookup[result.year][result.category] = result.winner
end
```

`Hash.of` enables the terser:

```ruby
award_results.each_with_object(Hash.of(:hash)) do |result, lookup|
  lookup[result.year][result.category] = result.winner
end

# or the incredibly terse inline

award_results.each_with_object(Hash.of(:hash)) { _2[_1.year][_1.category] = _1.winner }
```

Both result in the following object that powers the specified interface:

```ruby
{
  2024 => {
    :best_picture => "Oppenheimer",
    :best_actor => "Cillian Murphy",
    …
  },
  2023 => {
    :best_picture => "Everything Everywhere All at Once",
    …
  },
  2022 => {
    :best_picture => "CODA",
    …
  }
}
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add hash_of

Alternatively add to your `Gemfile` via

    gem "hash_of", "~> 1.0"

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install hash_of


## Usage

`Hash.of` provides the following uses

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

Bug reports and pull requests are welcome on GitHub at https://github.com/agrberg/hash_of.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
