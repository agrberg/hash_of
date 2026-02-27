# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

hash_of is a Ruby gem that extends `Hash` with a `.of()` class method for creating auto-populating hashes (arrays, hashes, or recursive hashes). It targets Ruby 3.0+.

## Commands

```bash
bundle exec rake          # Default: runs tests + rubocop
bundle exec rake spec     # Run RSpec tests only
bundle exec rubocop       # Run linting only
bundle exec rspec spec/hash_of_spec.rb  # Run a single test file
bundle exec rake coverage # Generate coverage report and open in browser
```

## Architecture

The entire gem is a single module in `lib/hash_of.rb`. It defines three lambdas (`OF_ARRAY_LAMBDA`, `OF_HASH_LAMBDA`, `OF_HASH_RECURSIVE_LAMBDA`) used as `default_proc` values and a single `of(type, recursive: false)` method. The module is extended onto `Hash` directly via `Hash.extend(HashOf)`.

All tests live in `spec/hash_of_spec.rb`. Coverage is tracked with SimpleCov.

## Style

- RuboCop enforced: double-quoted strings, 120 char max line length
- CI tests against Ruby 3.0, 3.1, 3.2, 3.3
