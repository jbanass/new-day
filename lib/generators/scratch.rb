require 'erb'

module Generators
  class Scratch
    def generate
      render
    end

    private

    def template_content
      File.read(File.join(File.dirname(__FILE__), '..', 'templates', 'scratch.org.erb'))
    end

    def render
      ERB.new(template_content).result(binding)
    end
  end
end
