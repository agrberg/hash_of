# 1.1.0 (February 27, 2026)

- Raise `ArgumentError` for invalid type arguments (e.g., `Hash.of(:string)`)
- Raise `ArgumentError` when passing `recursive: true` with `:array`
- Drop Ruby < 3.3 support; now tested on Ruby 3.3, 3.4, and 4.0
- Update all dependencies (rubocop 1.85, rubocop-rspec 3.x, etc.)

# 1.0.1 (February 12, 2024)

- Simpler internal approach for creating the recursive hash that avoids a new class

# 1.0.0 (February 4, 2024)

## Features:

- Initial release
- Introduces `Hash.of` to create a new hash where unrecognized keys are new objects as specified
  - `Hash.of(:array)[:any_key] #=> []`
  - `Hash.of(:hash)[:any_key] #=> {}`
  - `Hash.of(:hash, recursive: true)[:any_key][:and_another][:or_more] #=> {}`
