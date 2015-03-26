source 'https://rubygems.org'
gemspec

group :development, :test do
  gem 'machinist'
  gem 'minitest'
  gem 'rspec_junit_formatter'
end

group :test do
  %w[rspec-core rspec-expectations rspec-mocks rspec-support].each do |lib|
    gem lib
  end
end

