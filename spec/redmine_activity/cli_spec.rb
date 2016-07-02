describe RedmineActivity::CLI do
  let(:command) { 'redmine_activity' }

  subject { -> { described_class.start(thor_args) } }

  describe '#today' do
    let(:fetcher_mock) { instance_double('fetcher') }

    context 'given no options' do
      let(:options) { {} }
      let(:thor_args) { %w(today) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:today).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --url option' do
      let(:options) { { 'url' => 'http://example.com/' } }
      let(:thor_args) { %w(today --url=http://example.com/) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:today).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --login-id option' do
      let(:options) { { 'login_id' => 'beer' } }
      let(:thor_args) { %w(today --login-id=beer) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:today).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --password option' do
      let(:options) { { 'password' => 'whiskey' } }
      let(:thor_args) { %w(today --password=whiskey) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:today).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given undefined --tea option' do
      let(:thor_args) { %w(today --tea) }
      let(:message) do
        <<-EOS
ERROR: "#{command} today" was called with arguments ["--tea"]
Usage: "#{command} today"
        EOS
      end

      before do
        expect(File).to receive(:basename).with($PROGRAM_NAME).and_return(command).at_least(:once)
      end

      it { is_expected.to output(message).to_stderr }
    end
  end

  describe '#version' do
    context 'given --version option' do
      let(:thor_args) { %w(--version) }
      it { is_expected.to output("#{command} #{RedmineActivity::VERSION}\n").to_stdout }
    end

    context 'given -v option' do
      let(:thor_args) { %w(-v) }
      it { is_expected.to output("#{command} #{RedmineActivity::VERSION}\n").to_stdout }
    end
  end
end
