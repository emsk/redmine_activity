# RedmineActivity

[![Build Status](https://travis-ci.org/emsk/redmine_activity.svg?branch=master)](https://travis-ci.org/emsk/redmine_activity)
[![Coverage Status](https://coveralls.io/repos/github/emsk/redmine_activity/badge.svg?branch=master)](https://coveralls.io/github/emsk/redmine_activity)
[![Code Climate](https://codeclimate.com/github/emsk/redmine_activity/badges/gpa.svg)](https://codeclimate.com/github/emsk/redmine_activity)
[![Dependency Status](https://gemnasium.com/badges/github.com/emsk/redmine_activity.svg)](https://gemnasium.com/github.com/emsk/redmine_activity)
[![Inline docs](http://inch-ci.org/github/emsk/redmine_activity.svg?branch=master)](http://inch-ci.org/github/emsk/redmine_activity)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)

Summarize one day's activities on Redmine.

## Prerequisite

You have to install Ruby 2.0.0 or higher.

## Installation

```sh
$ git clone https://github.com/emsk/redmine_activity.git
$ cd redmine_activity
$ gem build redmine_activity.gemspec
$ gem install redmine_activity-0.1.0.gem
```

## Usage

Print today's activities:

```sh
$ redmine_activity --url=http://example.com/redmine --login-id=admin --password=pass
Example Project - 機能 #1 (新規): チケット１ (田中 太郎) (2016-01-23 12:34:56)
Example Project - 機能 #2 (新規): チケット２ (山田 花子) (2016-01-23 13:45:12)
```

Print yesterday's activities:

```sh
$ redmine_activity yesterday --url=http://example.com/redmine --login-id=admin --password=pass
```

Print one day's activities:

```sh
$ redmine_activity --date=2016-01-01 --url=http://example.com/redmine --login-id=admin --password=pass
```

## Command Options

| Option | Description | Type |
| :----- | :---------- | :--- |
| `--url` | Redmine URL | String |
| `--login-id` | Login ID | String |
| `--password` | Login password | String |
| `--user-id` | Target user ID | Integer |
| `--project` | Target project identifier | String |
| `--date` | Target date | String |

## ENV

| ENV Variable | Description |
| :----------- | :---------- |
| `REDMINE_ACTIVITY_URL` | Redmine URL |
| `REDMINE_ACTIVITY_LOGIN_ID` | Redmine login ID |
| `REDMINE_ACTIVITY_PASSWORD` | Redmine password |

You can execute the command without passing options.

## Documentation

http://www.rubydoc.info/github/emsk/redmine_activity

## Supported Ruby Versions

* Ruby 2.0.0
* Ruby 2.1
* Ruby 2.2
* Ruby 2.3

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/emsk/redmine_activity.

## Related

* [mruby-redmine_activity](https://github.com/emsk/mruby-redmine_activity) - An mruby implementation of the redmine_activity

## License

[MIT](LICENSE.txt)
