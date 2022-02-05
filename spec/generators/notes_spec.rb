require 'spec_helper'
require_relative '../../lib/generators/note'

describe Generators::Note do
  subject { described_class.new }

  let(:expected_result) {
    <<~ORG
      # This serves as a general notetaking area for items experienced during the day

      # Helpful shortcuts:
      #   (C-u C-c C-o): Open a link
    ORG
  }

  describe "#generate" do
    it "renders the template" do
      expect(subject.generate).to eq(expected_result)
    end
  end
end
