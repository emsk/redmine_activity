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
    # @option options [Fixnum] :user_id User ID
    # @option options [String] :date Date
    def initialize(options = {})
      @url      = ENV['REDMINE_ACTIVITY_URL']
      @login_id = ENV['REDMINE_ACTIVITY_LOGIN_ID']
      @password = ENV['REDMINE_ACTIVITY_PASSWORD']

      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end

      @agent = Mechanize.new
    end

    # Fetch and print activities
    def get
      login
      parse(activities)
    rescue Mechanize::ResponseCodeError => e
      puts Rainbow('404 Not Found.').red if e.response_code == '404'
    end

    private

    def login
      login_page = @agent.get(login_url)
      login_page.form_with(LOGIN_CRITERIA) do |form|
        form.username = @login_id
        form.password = @password
      end.submit
    end

    def login_url
      "#{@url}/login"
    end

    def activities
      body = @agent.get(activity_atom_url, activity_atom_params).body
      Nokogiri::XML(body)
    end

    def activity_atom_url
      "#{@url}/activity.atom"
    end

    def activity_atom_params
      params = ACTIVITY_ATOM_PARAMS.dup
      params[:from] = @date if @date
      params[:user_id] = @user_id if @user_id
      params
    end

    def parse(xml)
      xml.css('entry').each do |entry|
        title = entry.css('title').text
        updated = entry.css('updated').text
        updated_time = Time.parse(updated).utc

        puts "#{Rainbow(title).yellow} (#{updated})" if cover?(updated_time)
      end
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
