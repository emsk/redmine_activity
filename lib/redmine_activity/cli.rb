require 'thor'
require 'redmine_activity/fetcher'

# Summarize activities on Redmine
module RedmineActivity
  # Command-line interface of {RedmineActivity}
  class CLI < Thor
    desc 'get', "Print one day's activities"
    option :url, type: :string
    option :login_id, type: :string
    option :password, type: :string
    option :date, type: :string

    # Print one day's activities
    def get
      fetcher_options = options.dup
      fetcher_options[:date] = @date if @date
      fetcher = Fetcher.new(fetcher_options)
      fetcher.get
    end

    desc 'today', "Print today's activities"
    option :url, type: :string
    option :login_id, type: :string
    option :password, type: :string

    # Print today's activities
    def today
      get
    end

    desc 'yesterday', "Print yesterday's activities"
    option :url, type: :string
    option :login_id, type: :string
    option :password, type: :string

    # Print yesterday's activities
    def yesterday
      @date = Date.yesterday.to_s
      get
    end

    desc '-v, --version', 'Print the version'
    map %w(-v --version) => :version

    # Print the version
    def version
      puts "redmine_activity #{RedmineActivity::VERSION}"
    end
  end
end
