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
