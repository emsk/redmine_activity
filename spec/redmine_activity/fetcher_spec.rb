# coding: utf-8

describe RedmineActivity::Fetcher do
  describe '#get' do
    subject { -> { fetcher.get } }

    context 'with --date option', vcr: { cassette_name: 'with_date_option' } do
      let(:fetcher) do
        described_class.new(
          url: ENV['REDMINE_ACTIVITY_URL'],
          login_id: ENV['REDMINE_ACTIVITY_LOGIN_ID'],
          password: ENV['REDMINE_ACTIVITY_PASSWORD'],
          date: date
        )
      end

      before do
        expect(Date).to receive(:parse).and_return(Date.parse(date).in_time_zone('Asia/Tokyo')).once
      end

      context 'when activities exist' do
        let(:date) { '2016-06-23' }
        let(:message) do
          <<-EOS
Sample Project 1 - 機能 #51 (新規): サンプルチケット３ (2016-06-22T15:00:00Z)
          EOS
        end

        it { is_expected.to output(message).to_stdout }
      end
    end

    context 'without --date option', vcr: { cassette_name: 'without_date_option' } do
      let(:fetcher) do
        described_class.new(
          url: ENV['REDMINE_ACTIVITY_URL'],
          login_id: ENV['REDMINE_ACTIVITY_LOGIN_ID'],
          password: ENV['REDMINE_ACTIVITY_PASSWORD']
        )
      end

      before do
        expect(Date).to receive(:today).and_return(Date.parse(date).in_time_zone('Asia/Tokyo')).once
      end

      context 'when activities exist' do
        let(:date) { '2016-06-22' }
        let(:message) do
          <<-EOS
Sample Project 1 - 機能 #50 (新規): サンプルチケット２ (2016-06-22T14:59:59Z)
Sample Project 1 - 機能 #49 (新規): サンプルチケット１ (2016-06-22T12:52:58Z)
          EOS
        end

        it { is_expected.to output(message).to_stdout }
      end

      context 'when activities do not exist' do
        let(:date) { '2016-06-24' }
        it { is_expected.not_to output.to_stdout }
      end
    end

    context 'with --user-id option', vcr: { cassette_name: 'with_user_id_option' } do
      let(:fetcher) do
        described_class.new(
          url: ENV['REDMINE_ACTIVITY_URL'],
          login_id: ENV['REDMINE_ACTIVITY_LOGIN_ID'],
          password: ENV['REDMINE_ACTIVITY_PASSWORD'],
          user_id: user_id
        )
      end

      before do
        expect(Date).to receive(:today).and_return(Date.parse(date).in_time_zone('Asia/Tokyo')).once
      end

      context 'when activities exist' do
        let(:user_id) { 2 }
        let(:date) { '2016-06-25' }
        let(:message) do
          <<-EOS
Sample Project 1 - 機能 #53 (新規): サンプルチケット５ (2016-06-25T14:59:59Z)
Sample Project 1 - 機能 #52 (新規): サンプルチケット４ (2016-06-24T15:00:00Z)
          EOS
        end

        it { is_expected.to output(message).to_stdout }
      end
    end

    context 'with invalid --user-id option', vcr: { cassette_name: 'with_invalid_user_id_option' } do
      let(:fetcher) do
        described_class.new(
          url: ENV['REDMINE_ACTIVITY_URL'],
          login_id: ENV['REDMINE_ACTIVITY_LOGIN_ID'],
          password: ENV['REDMINE_ACTIVITY_PASSWORD'],
          user_id: user_id
        )
      end
      let(:user_id) { 0 }
      let(:message) { "404 Not Found.\n" }

      it { is_expected.to output(message).to_stdout }
    end
  end
end
