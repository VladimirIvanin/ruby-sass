require 'rubygems'

# Note that Sass's gem-compilation process requires access to the filesystem.
# This means that it cannot be automatically run by e.g. GitHub's gem system.
# However, a build server automatically packages the master branch
# every time it's pushed to; this is made available as a prerelease gem.
SASS_GEMSPEC = Gem::Specification.new do |spec|
  spec.name = 'sass4'
  spec.summary = "A powerful but elegant CSS compiler that makes CSS fun again."
  spec.version = File.read(File.dirname(__FILE__) + '/VERSION').strip
  spec.authors = ['Natalie Weizenbaum', 'Chris Eppstein', 'Hampton Catlin', 'Vladimir Ivanin']
  spec.email = 'ivaninww@gmail.com'
  spec.description = <<-END
      This is a fork of Ruby Sass with modern Ruby compatibility (Ruby 3.0+).
      Original Ruby Sass is deprecated! See https://github.com/sass/ruby-sass for details.

      Sass makes CSS fun again. Sass is an extension of CSS, adding
      nested rules, variables, mixins, selector inheritance, and more.
      It's translated to well-formatted, standard CSS using the
      command line tool or a web-framework plugin.
    END

  spec.required_ruby_version = '>= 3.0.0'

  spec.add_runtime_dependency 'sass-listen', '~> 4.0.0'

  spec.add_development_dependency 'yard', '~> 0.9.0'
  spec.add_development_dependency 'redcarpet', '~> 3.6.0'
  spec.add_development_dependency 'nokogiri', '~> 1.15.0'
  spec.add_development_dependency 'minitest', '~> 5.20'

  readmes = Dir['*'].reject{ |x| x =~ /(^|[^.a-z])[a-z]+/ || x == "TODO" }
  spec.executables = ['sass', 'sass-convert', 'scss']
  spec.files = Dir['rails/init.rb', '{lib,bin,extra}/**/*', 'init.rb', '.yardopts'] + readmes
  spec.homepage = 'https://github.com/VladimirIvanin/ruby-sass'
  spec.license = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['source_code_uri'] = 'https://github.com/VladimirIvanin/ruby-sass'
  end

  spec.post_install_message = <<END

Ruby Sass has reached end-of-life and should no longer be used.

* If you use Sass as a command-line tool, we recommend using Dart Sass, the new
  primary implementation: https://sass-lang.com/install

* If you use Sass as a plug-in for a Ruby web framework, we recommend using the
  sassc gem: https://github.com/sass/sassc-ruby#readme

* For more details, please refer to the original repository:
  https://github.com/sass/ruby-sass

END
end
