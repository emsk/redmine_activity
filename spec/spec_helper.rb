require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'redmine_activity'
require 'webmock/rspec'
require 'vcr'

WebMock.disable_net_connect!(allow: 'coveralls.io')

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.ignore_request do |request|
    request.headers.has_key?('Referer')
  end

  c.filter_sensitive_data('<REDMINE_ACTIVITY_URL>') { ENV['REDMINE_ACTIVITY_URL'] }
  c.filter_sensitive_data('<REDMINE_ACTIVITY_HOST>') do |interaction|
    interaction.request.headers['Host'][0]
  end
end
