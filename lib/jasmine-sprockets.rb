require "jasmine"
require "rack"
require "sprockets"
require "jasmine-sprockets/jasmine_file"
require "jasmine-sprockets/version"

module Jasmine

  def self.app(config)
    Rack::Builder.app {
      use Rack::Head

      map('/run.html')         { run Jasmine::Redirect.new('/') }
      map('/__suite__')        { run Jasmine::FocusedSuite.new(config) }

      map('/__JASMINE_ROOT__') { run Rack::JasmineFile.new(Jasmine::Core.path) }
      map(config.spec_path)    { run Rack::JasmineFile.new(config.spec_dir) }
      map(config.root_path)    { run Rack::JasmineFile.new(config.project_root) }

      map('/') do
        run Rack::Cascade.new([
          Rack::URLMap.new('/' => Rack::JasmineFile.new([config.src_dir]+config.sprocket_dirs)),
          Jasmine::RunAdapter.new(config)
        ])
      end
    }
  end

end

module Jasmine
  class Config
    def sprocket_dirs
      if simple_config['sprocket_dirs']
        simple_config['sprocket_dirs'].map{|d| File.join project_root, d }
      else
        [File.join(project_root, "vendor")]
      end
    end
  end
end