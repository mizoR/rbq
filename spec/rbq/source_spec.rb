require 'spec_helper'

describe Rbq::Source do
  subject { source }

  describe '.#new' do
    subject { source }

    let(:source) { described_class.new(*args) }

    describe 'Default' do
      let(:args) { ['{"a": 1}'] }

      it { is_expected.to eq({'a' => 1}) }
    end

    describe 'JSON' do
      let(:args) { ['{"a": 1}', {format: :json}] }

      it { is_expected.to eq({'a' => 1}) }
    end

    describe 'YAML' do
      let(:args) { ['a: 1', {format: :yaml}] }

      it { is_expected.to eq({'a' => 1}) }
    end

    describe 'Text' do
      let(:args) { ['i love ruby', {format: :text}] }

      it { is_expected.to eq('i love ruby') }
    end
  end
end
