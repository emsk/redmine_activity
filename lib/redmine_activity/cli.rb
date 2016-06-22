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

    desc '-v, --version', 'Print the version'
    map %w(-v --version) => :version

    # Print the version
    def version
      puts "redmine_activity #{RedmineActivity::VERSION}"
    end
  end

  CLI.start
end
