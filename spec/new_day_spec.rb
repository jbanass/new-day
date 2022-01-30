require 'spec_helper'
require 'date'
require_relative '../lib/new_day'

describe NewDay do

  subject { described_class.new(notes_directory: notes_directory) }

  let(:notes_directory) { '/tmp' }
  let(:year) { DateTime.now.strftime('%Y') }
  let(:month) { DateTime.now.strftime('%m') }
  let(:day) { DateTime.now.strftime('%d') }
  let(:directory_to_create) { Pathname.new(notes_directory).join(year, month, day) }


  describe '#create_directory' do
    it 'creates the path' do
      expect(FileUtils).to receive(:mkdir_p).once
      subject.create_directory
    end
  end

  describe '#directory_exists?' do
    context 'when the path does not exist' do
      it 'returns false' do
        allow(File).to receive(:exists?).with(directory_to_create).and_return(false)
        subject.directory_exists?
      end
    end

    context 'when the path does exist' do
      it 'returns true' do
        allow(File).to receive(:exists?).with(directory_to_create).and_return(true)
        subject.directory_exists?
      end
    end
  end

  describe 'file generators' do
    context "TODO generator" do
      let(:mock_generator) { spy(generate: 'TODO') }

      it 'fetches the TODO template from the TodoGenerator' do
        expect(subject).to receive(:todo_generator).once.and_return(mock_generator)
        subject.run
        expect(mock_generator).to have_received(:generate).once
      end
    end

    context "NOTES generator" do
      let(:mock_generator) { spy(generate: 'NOTES') }

      it 'fetches the NOTES template from the NoteGenerator' do
        expect(subject).to receive(:note_generator).and_return(mock_generator)
        subject.run
        expect(mock_generator).to have_received(:generate).once
      end
    end

    context "SCRATCH generator" do
      let(:mock_generator) { spy(generate: 'SCRATCH') }

      it 'fetches the SCRATCH template from the TemplateGenerator' do
        expect(subject).to receive(:scratch_generator).and_return(mock_generator)
        subject.run
        expect(mock_generator).to have_received(:generate).once
      end
    end
  end

  describe '#create_file' do
    it 'writes content to a file within the notes directory' do
      buffer = StringIO.new
      allow(File).to receive(:exists?).with(directory_to_create.join("todo.org")).once.and_return(false)
      allow(File).to receive(:open).with(directory_to_create.join('todo.org'), 'w').and_yield(buffer)
      subject.create_file('todo.org', 'TODO')
      expect(buffer.string).to eq('TODO')
    end

    context 'when a file already exists' do
      it 'does not overwrite' do
        expect(File).to receive(:exists?).with(directory_to_create.join('todo.org')).once.and_return(true)
        expect(File).not_to receive(:open)
        subject.create_file('todo.org', 'TODO')
      end
    end
  end

  describe 'run' do
    it "calls each generator once" do
      allow(subject).to receive(:create_file)
      expect(subject).to receive(:scratch_generator).once.and_call_original
      expect(subject).to receive(:note_generator).once.and_call_original
      expect(subject).to receive(:todo_generator).once.and_call_original
      subject.run
    end
  end
end
