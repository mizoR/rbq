require 'spec_helper'

describe Rbq::Evaluator do
  subject { evaluator }
  let(:evaluator) { described_class.new(data) }

  describe '#evaluate' do
    subject { evaluator.evaluate(script) }

    let(:data)   { [:ruby, :life] }
    let(:script) { 'map {|w| "no #{w}"}.join(", ").capitalize << "."' }

    it { is_expected.to eq "No ruby, no life."}
  end
end
