require 'spec_helper'

describe Rbq::CLI do
  shared_examples_for 'dump as JSON' do |options|
    context "when extraction the languages' name of 4-characters" do
      let(:argv)   { ['--from', options[:from], script] }
      let(:script) { 'select {|language| language["lang"].length == 4}.map {|language| language["lang"]}' }

      it { is_expected.to eq JSON.pretty_generate(%w|Java Perl Ruby|) + "\n" }
    end
  end

  shared_examples_for 'dump as YAML' do |options|
    context 'when detection the language name born the earliest, and dump as YAML' do
      let(:argv)   { ['--from', options[:from], '--to', 'yaml', script] }
      let(:script) { 'max_by {|language| language["born_in"]}' }

      it { is_expected.to eq YAML.dump('lang' => 'C#', 'born_in' => 2000, 'inspired_by' => %w|Delphi Java C++ Ruby|) }
    end
  end

  shared_examples_for 'dump as CSV' do |options|
    context "when extraction the languages inspired over 4 languages, and dump as CSV" do
      let(:argv)   { ['--from', options[:from], '--to', 'csv', script] }
      let(:script) { 'select {|language| language["inspired_by"].length >= 4}.map {|language| [language["lang"], language["inspired_by"].count]}' }

      it do
        is_expected.to eq CSV.generate {|csv|
          csv << ["C#",         4]
          csv << ["JavaScript", 4]
          csv << ["Perl",       5]
          csv << ["Ruby",       4]
        }
      end
    end
  end

  shared_examples_for 'dump as String' do |options|
    context "when Ruby was born in?" do
      let(:argv)   { ['--from', options[:from], '--to', 'string', script] }
      let(:script) { 'detect {|language| language["lang"] == "Ruby"}.slice("born_in").flatten.unshift("Ruby was").join(" ").gsub(/_/, " ")' }

      it do
        is_expected.to eq "Ruby was born in 1995\n"
      end
    end
  end

  before do
    allow($stdin).to receive(:tty?).and_return(false)
    allow($stdin).to receive(:read).and_return(data)

    allow($stdout).to receive(:tty?).and_return(false)
  end

  let(:cli) { described_class.new(argv) }

  let(:languages) do
    [
      {lang: 'C',          born_in: 1973, inspired_by: %w|Algol B|},
      {lang: 'C++',        born_in: 1980, inspired_by: %w|C Simula Algol|},
      {lang: 'C#',         born_in: 2000, inspired_by: %w|Delphi Java C++ Ruby|},
      {lang: 'Java',       born_in: 1994, inspired_by: %w|C++ Objective-C C#|},
      {lang: 'JavaScript', born_in: 1995, inspired_by: %w|C Self awk Perl|},
      {lang: 'Perl',       born_in: 1987, inspired_by: %w|C shell AWK sed LISP|},
      {lang: 'PHP',        born_in: 1995, inspired_by: %w|Perl C|},
      {lang: 'Python',     born_in: 1991, inspired_by: %w|ABC Perl Modula-3|},
      {lang: 'Ruby',       born_in: 1995, inspired_by: %w|Perl Smalltalk LISP CLU|},
    ].map(&:stringify_keys)
  end

  describe '#run' do
    subject { capture(:stdout) { cli.run } }

    describe 'import as JSON' do
      let(:data)   { JSON.generate(languages) }

      it_behaves_like 'dump as JSON', from: 'json'

      it_behaves_like 'dump as YAML', from: 'json'

      it_behaves_like 'dump as CSV', from: 'json'

      it_behaves_like 'dump as String', from: 'json'
    end

    describe 'import as YAML' do
      let(:data)   { YAML.dump(languages) }

      it_behaves_like 'dump as JSON', from: 'yaml'

      it_behaves_like 'dump as YAML', from: 'yaml'

      it_behaves_like 'dump as CSV', from: 'yaml'

      it_behaves_like 'dump as String', from: 'yaml'
    end
  end
end
