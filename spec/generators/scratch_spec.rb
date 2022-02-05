require 'spec_helper.rb'
require_relative '../../lib/generators/scratch'

describe Generators::Scratch do
  subject { described_class.new }

  let(:expected_result ) {
    <<~ORG
      # This file serves as a temporary area for snippets during the day

      # Helpful shortcuts:
      #   (C-u C-c C-o): Open a link
    ORG
  }

  describe '#generate' do
    it "generates the template" do
      expect(subject.generate).to eq(expected_result)
    end
  end
end
