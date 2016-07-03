describe RedmineActivity::Fetcher do
  let(:fetcher) do
    described_class.new(
      url: ENV['REDMINE_ACTIVITY_URL'],
      login_id: ENV['REDMINE_ACTIVITY_LOGIN_ID'],
      password: ENV['REDMINE_ACTIVITY_PASSWORD']
    )
  end

  describe '#today', vcr: { cassette_name: 'today' } do
    before do
      expect(Date).to receive(:today).and_return(Date.parse(date)).twice
    end

    subject { -> { fetcher.today } }

    context 'when activities exist' do
      let(:date) { '2016-06-22' }
      let(:message) do
        <<-EOS
Sample Project 1 - 機能 #50 (新規): サンプルチケット２ (2016-06-22 22:09:22)
Sample Project 1 - 機能 #49 (新規): サンプルチケット１ (2016-06-22 21:52:58)
        EOS
      end

      it { is_expected.to output(message).to_stdout }
    end

    context 'when activities do not exist' do
      let(:date) { '2016-06-23' }
      it { is_expected.not_to output.to_stdout }
    end
  end
end
