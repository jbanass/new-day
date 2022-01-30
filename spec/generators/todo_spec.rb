require "spec_helper"
require_relative '../../lib/generators/todo'
require 'date'

describe Generators::Todo do
  subject { described_class.new }

  describe "#generate" do
    let(:expected_output) {
      <<~ORG
      #+TITLE: Todo for #{ DateTime.now.strftime("%Y/%m/%d") }
      #+TODO: TODO IN-PROGRESS WAITING DONE

      # Helpful shortcuts:
      #   (C-c C-c): Recalc statistic cookies/cycle checkboxes
      ORG
    }

    it "returns a todo org template" do
      expect(subject.generate).to eq(expected_output)
    end
  end
end
