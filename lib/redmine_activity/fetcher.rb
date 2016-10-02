require 'active_support/time'
require 'mechanize'

module RedmineActivity
  # Class to fetch and parse activity page
  class Fetcher
    LOGIN_CRITERIA = { action: '/redmine/login' }
    ACTIVITY_ATOM_PARAMS = { show_issues: 1 }

    # Initialize a new Fetcher object
    #
    # @param options [Hash] Initialize options
    # @option options [String] :url Redmine URL
    # @option options [String] :login_id Login ID
    # @option options [String] :password Password
    # @option options [String] :date Date
    def initialize(options = {})
      @url      = ENV['REDMINE_ACTIVITY_URL']
      @login_id = ENV['REDMINE_ACTIVITY_LOGIN_ID']
      @password = ENV['REDMINE_ACTIVITY_PASSWORD']

      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    # Fetch and print activities
    def get
      agent = Mechanize.new
      login_page = agent.get(login_url)
      login_page.form_with(LOGIN_CRITERIA) do |form|
        form.username = @login_id
        form.password = @password
      end.submit

      body = agent.get(activity_atom_url, activity_atom_params).body
      xml = Nokogiri::XML(body)
      xml.css('entry').each do |entry|
        title = entry.css('title').text
        updated = entry.css('updated').text
        updated_time = Time.parse(updated).utc

        puts "#{Rainbow(title).yellow} (#{updated})" if cover?(updated_time)
      end
    end

    private

    def login_url
      "#{@url}/login"
    end

    def activity_atom_url
      "#{@url}/activity.atom"
    end

    def activity_atom_params
      return ACTIVITY_ATOM_PARAMS unless @date
      ACTIVITY_ATOM_PARAMS.merge(from: @date)
    end

    def cover?(time)
      time_range.cover?(time)
    end

    def time_range
      return @time_range if @time_range

      date = @date ? Date.parse(@date) : Date.today
      @time_range = date.beginning_of_day..date.end_of_day
    end
  end
end
