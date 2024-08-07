# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

desc "Generage code coverage with simplecov"
task :coverage do
  `COVERAGE=true rake`
  `open coverage/index.html`
end
