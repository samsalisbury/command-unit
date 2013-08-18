Gem::Specification.new do |s|
  s.name              = "command-unit"
  s.version           = "0.0.2"
  s.platform          = Gem::Platform::RUBY
  s.author           = "Samuel R. Salisbury"
  s.email             = "samsalisbury@gmail.com"
  s.homepage          = "http://github.com/samsalisbury/command-unit"
  s.summary           = "ALPHA: Lightweight test runner for command line tools."
  s.description       = "ALPHA: Test runner for one-shot command line tools. This was built to support writing git hooks over at http://github.com/samsalisbury/righteous-git-hooks"
  
  s.rubyforge_project = s.name

  s.required_rubygems_version = ">= 1.3.6"
 
  # If you have runtime dependencies, add them here
  # s.add_runtime_dependency "other", "~&gt; 1.2"
 
  # If you have development dependencies, add them here
  # s.add_development_dependency "another", "= 0.9"
 
  # The list of files to be contained in the gem 
  s.files         = `git ls-files`.split("\n")
  # s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
 
  s.require_path = 'lib'
 
  # For C extensions
  # s.extensions = "ext/extconf.rb"
end