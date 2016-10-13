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
Sample Project 1 - 機能 #51 (新規): サンプルチケット３ (テスト ユーザ１) (2016-06-22T15:00:00Z)
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
Sample Project 1 - 機能 #50 (新規): サンプルチケット２ (テスト ユーザ１) (2016-06-22T14:59:59Z)
Sample Project 1 - 機能 #49 (新規): サンプルチケット１ (テスト ユーザ１) (2016-06-22T12:52:58Z)
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
Sample Project 1 - 機能 #53 (新規): サンプルチケット５ (テスト ユーザ２) (2016-06-25T14:59:59Z)
Sample Project 1 - 機能 #52 (新規): サンプルチケット４ (テスト ユーザ２) (2016-06-24T15:00:00Z)
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

    context 'with --project option', vcr: { cassette_name: 'with_project_option' } do
      let(:fetcher) do
        described_class.new(
          url: ENV['REDMINE_ACTIVITY_URL'],
          login_id: ENV['REDMINE_ACTIVITY_LOGIN_ID'],
          password: ENV['REDMINE_ACTIVITY_PASSWORD'],
          project: project
        )
      end

      before do
        expect(Date).to receive(:today).and_return(Date.parse(date).in_time_zone('Asia/Tokyo')).once
      end

      context 'when activities exist' do
        let(:project) { 'sample-project-1' }
        let(:date) { '2016-10-14' }
        let(:message) do
          <<-EOS
Sample Project 1 - 機能 #54 (新規): サンプルチケット６ (テスト ユーザ１) (2016-10-13T15:00:00Z)
          EOS
        end

        it { is_expected.to output(message).to_stdout }
      end
    end

    context 'with invalid --project option', vcr: { cassette_name: 'with_invalid_project_option' } do
      let(:fetcher) do
        described_class.new(
          url: ENV['REDMINE_ACTIVITY_URL'],
          login_id: ENV['REDMINE_ACTIVITY_LOGIN_ID'],
          password: ENV['REDMINE_ACTIVITY_PASSWORD'],
          project: project
        )
      end
      let(:project) { 'sample-project-2' }
      let(:message) { "404 Not Found.\n" }

      it { is_expected.to output(message).to_stdout }
    end
  end
end
