require 'rubygems'
require 'rubygems/package_task'
require 'rspec/core/rake_task'

Dir['tasks/**/*.rb'].each { |t| load t }

spec = Gem::Specification.new do |s|
  s.name = "hiera-property_central"
  s.version = described_version
  s.author = "Wouter van Bommel"
  s.email = "info@vanbommelonline.nl"
  s.homepage = "https://github.com/woutervb/hiera-central_property"
  s.summary = "central_property backend for the Hiera hierarcical data store"
  s.description = "Store Hiera data in Central_property"
  s.files = FileList["lib/**/*"].to_a
  s.require_path = "lib"
  s.has_rdoc = false
  s.add_dependency 'hiera', '~>0.3.0'
end

Gem::PackageTask.new(spec) do  |pkg|
  pkg.need_tar = true
end

task :default => [:repackage]