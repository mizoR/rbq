require 'spec_helper'

describe Rbq::Destination do
  describe '.#new' do
    subject { dst }

    let(:dst) { described_class.new(data, format: format) }
    let(:data) { [1, {foo: "bar"}] }

    before do
      STDOUT.stub(:tty?).and_return(false)
    end

    context do
      let(:format) { 'json' }
      it { is_expected.to be_a described_class::JSON }
      its(:to_s) { is_expected.to eq "[\n  1,\n  {\n    \"foo\": \"bar\"\n  }\n]" }
    end

    context do
      let(:format) { 'yaml' }
      it { is_expected.to be_a described_class::YAML }
      its(:to_s) { is_expected.to eq "---\n- 1\n- :foo: bar\n" }
    end

    context do
      let(:format) { 'ruby' }
      it { is_expected.to be_a described_class::Ruby }
      its(:to_s) { is_expected.to eq "[\n    [0] 1,\n    [1] {\n        :foo => \"bar\"\n    }\n]" }
    end

    context do
      let(:format) { 'text' }
      it { is_expected.to be_a described_class::Text }
      its(:to_s) { is_expected.to eq "[1, {:foo=>\"bar\"}]" }
    end
  end
end
