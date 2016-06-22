describe RedmineActivity::CLI do
  let(:cli) { described_class.new }

  describe '#version' do
    subject { -> { cli.version } }
    it { is_expected.to output("redmine_activity #{RedmineActivity::VERSION}\n").to_stdout }
  end
end
