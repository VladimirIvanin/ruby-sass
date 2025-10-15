source "https://rubygems.org"

gemspec

gem 'rake', '~> 13.0'
gem 'minitest', '~> 5.20', :group => :test

# Sass-spec по тегу v3.5.4 для совместимости (временно отключен из-за проблем с ruby-terminfo)
# gem "sass-spec", :git => 'https://github.com/sass/sass-spec.git', :tag => 'v3.5.4'

gem 'yard', '~> 0.9.0'
gem 'redcarpet', '~> 3.6.0'

# mathn удален из Ruby 3.0+, но нужен для тестов
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.0.0')
  gem 'mathn'
end
