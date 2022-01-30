require 'date'
require 'pathname'
require 'fileutils'

require_relative './generators/todo.rb'
require_relative './generators/note.rb'
require_relative './generators/scratch.rb'

class NewDay
  def initialize(notes_directory:)
    @notes_directory = notes_directory
  end

  def run
    create_directory unless directory_exists?
    ['todo', 'note', 'scratch'].each do |generator_type|
      create_file(
        "#{ generator_type }.org",
        self.send("#{ generator_type }_generator".to_sym).generate
      )
    end
  end

  def directory_exists?
    File.exists?(directory_to_create)
  end

  def create_file(filename, content)
    unless File.exists?(directory_to_create.join(filename))
      File.open(directory_to_create.join(filename), 'w') { |file| file.write(content) }
    end
  end

  def directory_to_create
    year, month, day = DateTime.now.strftime('%Y %m %d').split
    Pathname.new(notes_directory).join(year, month, day)
  end

  def create_directory
    FileUtils.mkdir_p(directory_to_create)
  end

  def notes_directory
    @notes_directory
  end

  private

  def scratch_generator
    Generators::Scratch.new
  end

  def todo_generator
    Generators::Todo.new
  end

  def note_generator
    Generators::Note.new
  end
end
