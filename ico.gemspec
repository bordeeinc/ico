# -*- encoding: utf-8 -*-
# stub: ico 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ico"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["So Awesome Man"]
  s.date = "2017-04-03"
  s.description = "ICO file format in Ruby"
  s.email = "support@bordee.com"
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.md", "History.txt"]
  s.files = [".autotest", ".gitignore", ".hoeignore", "Gemfile", "History.txt", "LICENSE", "Manifest.txt", "README.md", "Rakefile", "ico.gemspec", "lib/core_ext/array/extract_options.rb", "lib/ico.rb", "lib/ico/icon_dir.rb", "lib/ico/icon_dir_entry.rb", "lib/ico/icon_image.rb", "lib/ico/utils.rb", "lib/ico/version.rb", "lib/tasks/ico.rake"]
  s.homepage = "https://github.com/bordeeinc/ico"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--title", "ico", "--markup", "markdown", "--quiet"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.2.5"
  s.summary = "ICO file format in Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<chunky_png>, ["= 1.3.8"])
      s.add_runtime_dependency(%q<bit-struct>, ["= 0.15.0"])
      s.add_runtime_dependency(%q<bmp-ruby>, ["= 0.1.1"])
      s.add_development_dependency(%q<minitest>, ["~> 5.10"])
      s.add_development_dependency(%q<hoe-yard>, [">= 0.1.3"])
      s.add_development_dependency(%q<hoe-ignore>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-bundler>, ["~> 1.2"])
      s.add_development_dependency(%q<hoe-gemspec>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-git>, ["~> 1.6"])
      s.add_development_dependency(%q<yard>, ["~> 0.8"])
      s.add_development_dependency(%q<redcarpet>, ["~> 3.3"])
      s.add_development_dependency(%q<hoe>, ["~> 3.16"])
    else
      s.add_dependency(%q<chunky_png>, ["= 1.3.8"])
      s.add_dependency(%q<bit-struct>, ["= 0.15.0"])
      s.add_dependency(%q<bmp-ruby>, ["= 0.1.1"])
      s.add_dependency(%q<minitest>, ["~> 5.10"])
      s.add_dependency(%q<hoe-yard>, [">= 0.1.3"])
      s.add_dependency(%q<hoe-ignore>, ["~> 1.0"])
      s.add_dependency(%q<hoe-bundler>, ["~> 1.2"])
      s.add_dependency(%q<hoe-gemspec>, ["~> 1.0"])
      s.add_dependency(%q<hoe-git>, ["~> 1.6"])
      s.add_dependency(%q<yard>, ["~> 0.8"])
      s.add_dependency(%q<redcarpet>, ["~> 3.3"])
      s.add_dependency(%q<hoe>, ["~> 3.16"])
    end
  else
    s.add_dependency(%q<chunky_png>, ["= 1.3.8"])
    s.add_dependency(%q<bit-struct>, ["= 0.15.0"])
    s.add_dependency(%q<bmp-ruby>, ["= 0.1.1"])
    s.add_dependency(%q<minitest>, ["~> 5.10"])
    s.add_dependency(%q<hoe-yard>, [">= 0.1.3"])
    s.add_dependency(%q<hoe-ignore>, ["~> 1.0"])
    s.add_dependency(%q<hoe-bundler>, ["~> 1.2"])
    s.add_dependency(%q<hoe-gemspec>, ["~> 1.0"])
    s.add_dependency(%q<hoe-git>, ["~> 1.6"])
    s.add_dependency(%q<yard>, ["~> 0.8"])
    s.add_dependency(%q<redcarpet>, ["~> 3.3"])
    s.add_dependency(%q<hoe>, ["~> 3.16"])
  end
end
