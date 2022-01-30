require 'erb'

module Generators
  class Note
    def generate
      render
    end

    private

    def template_content
      File.read(File.join(File.dirname(__FILE__), '..', 'templates', 'notes.org.erb'))
    end

    def render
      ERB.new(template_content).result(binding)
    end
  end
end
