require 'thor'
require 'redmine_activity/fetcher'

module RedmineActivity
  # Command-line interface of {RedmineActivity}
  class CLI < Thor
    desc 'today', "Print today's activities"
    option :url, type: :string
    option :login_id, type: :string
    option :password, type: :string

    # Print today's activities
    def today
      fetcher = Fetcher.new(options)
      fetcher.today
    end
  end

  CLI.start
end
