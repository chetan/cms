
require "rubygems"

require "rake"
require "rake/gempackagetask"
require "rake/testtask"



spec = Gem::Specification.new do |s| 
    s.name = "pixelcop_cms"
    s.version = "0.1"
    s.author = "Chetan Sarva"
    s.email = "chetan@pixelcop.net"
    s.homepage = "http://www.chetanislazy.com/"
    s.platform = Gem::Platform::RUBY
    s.summary = "mini cms (and web) framework"
    s.files = FileList["{bin,lib}/**/*"].to_a
    s.require_path = "lib"
    s.autorequire = "pixelcop"
    s.test_files = FileList["{test}/**/*test.rb"].to_a
    s.has_rdoc = true
    s.extra_rdoc_files = ["README"]
    s.add_dependency("thin", ">= 1.2.4")
    s.add_dependency("mongo", ">= 0.16")
    s.add_dependency("mongo_ext", ">= 0.16")
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end

desc "Run unit tests"
Rake::TestTask.new("test") { |t|
    #t.libs << "tests"
    t.libs << "src/ruby"
    t.ruby_opts << "-rubygems"
    t.pattern = "tests/**/*.rb"
    t.verbose = true
    t.warning = false
}