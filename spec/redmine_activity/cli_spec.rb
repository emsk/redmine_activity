describe RedmineActivity::CLI do
  let(:command) { 'redmine_activity' }

  subject { -> { described_class.start(thor_args) } }

  describe '#get' do
    let(:fetcher_mock) { instance_double('fetcher') }

    context 'given no options' do
      let(:options) { {} }
      let(:thor_args) { %w(get) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --url option' do
      let(:options) { { 'url' => 'http://example.com/' } }
      let(:thor_args) { %w(get --url=http://example.com/) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --login-id option' do
      let(:options) { { 'login_id' => 'beer' } }
      let(:thor_args) { %w(get --login-id=beer) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --password option' do
      let(:options) { { 'password' => 'whiskey' } }
      let(:thor_args) { %w(get --password=whiskey) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --date option' do
      let(:options) { { 'date' => '2016-01-01' } }
      let(:thor_args) { %w(get --date=2016-01-01) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end
  end

  describe '#today' do
    let(:fetcher_mock) { instance_double('fetcher') }

    context 'given no options' do
      let(:options) { {} }
      let(:thor_args) { %w(today) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --url option' do
      let(:options) { { 'url' => 'http://example.com/' } }
      let(:thor_args) { %w(today --url=http://example.com/) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --login-id option' do
      let(:options) { { 'login_id' => 'beer' } }
      let(:thor_args) { %w(today --login-id=beer) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --password option' do
      let(:options) { { 'password' => 'whiskey' } }
      let(:thor_args) { %w(today --password=whiskey) }

      before do
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --date option' do
      let(:thor_args) { %w(today --date=2016-01-01) }
      let(:message) do
        <<-EOS
ERROR: "#{command} today" was called with arguments ["--date=2016-01-01"]
Usage: "#{command} today"
        EOS
      end

      before do
        expect(File).to receive(:basename).with($PROGRAM_NAME).and_return(command).at_least(:once)
      end

      it { is_expected.to output(message).to_stderr }
    end
  end

  describe '#yesterday' do
    let(:date) { '2016-09-01' }
    let(:fetcher_mock) { instance_double('fetcher') }

    context 'given no options' do
      let(:options) { { 'date' => date } }
      let(:thor_args) { %w(yesterday) }

      before do
        expect(Date).to receive_message_chain(:yesterday, :to_s).and_return(date)
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --url option' do
      let(:options) { { 'date' => date, 'url' => 'http://example.com/' } }
      let(:thor_args) { %w(yesterday --url=http://example.com/) }

      before do
        expect(Date).to receive_message_chain(:yesterday, :to_s).and_return(date)
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --login-id option' do
      let(:options) { { 'date' => date, 'login_id' => 'beer' } }
      let(:thor_args) { %w(yesterday --login-id=beer) }

      before do
        expect(Date).to receive_message_chain(:yesterday, :to_s).and_return(date)
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --password option' do
      let(:options) { { 'date' => date, 'password' => 'whiskey' } }
      let(:thor_args) { %w(yesterday --password=whiskey) }

      before do
        expect(Date).to receive_message_chain(:yesterday, :to_s).and_return(date)
        expect(RedmineActivity::Fetcher).to receive(:new).with(options).and_return(fetcher_mock)
        expect(fetcher_mock).to receive(:get).with(no_args)
      end

      it { is_expected.not_to output.to_stdout }
    end

    context 'given --date option' do
      let(:thor_args) { %w(yesterday --date=2016-01-01) }
      let(:message) do
        <<-EOS
ERROR: "#{command} yesterday" was called with arguments ["--date=2016-01-01"]
Usage: "#{command} yesterday"
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
