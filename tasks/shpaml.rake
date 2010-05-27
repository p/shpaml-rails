namespace :shpaml do
  desc 'Compiles all shpaml templates in app/views'
  task :compile do
    $: << File.join(File.dirname(__FILE__), '..', 'lib')
    
    require 'shpaml/discoverer'
    require 'shpaml/compiler'
    
    discoverer = Shpaml::Discoverer.new(File.join(Rails.root, 'app', 'views'))
    compiler = Shpaml::Compiler.new
    
    discoverer.find_shpaml_templates do |source_path|
      dest_path = source_path.sub(/\.shpaml$/, '')
      if source_path == dest_path
        raise ArgumentError, "Cannot compile a template to itself"
      end
      
      compiler.compile_file(source_path, dest_path)
    end
  end
end
