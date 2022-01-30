require 'erb'
require 'date'

module Generators
  class Todo
    def generate
      render
    end

    private

    def render
      ERB.new(template_content).result(binding)
    end

    def formatted_datetime
      DateTime.now.strftime("%Y/%m/%d")
    end

    def template_content
      File.read(File.join(File.dirname(__FILE__), '..', 'templates', 'todo.org.erb'))
    end
  end
end
