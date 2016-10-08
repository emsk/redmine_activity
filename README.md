# RedmineActivity

[![Build Status](https://travis-ci.org/emsk/redmine_activity.svg?branch=master)](https://travis-ci.org/emsk/redmine_activity)
[![Coverage Status](https://coveralls.io/repos/github/emsk/redmine_activity/badge.svg?branch=master)](https://coveralls.io/github/emsk/redmine_activity)
[![Code Climate](https://codeclimate.com/github/emsk/redmine_activity/badges/gpa.svg)](https://codeclimate.com/github/emsk/redmine_activity)
[![Dependency Status](https://gemnasium.com/badges/github.com/emsk/redmine_activity.svg)](https://gemnasium.com/github.com/emsk/redmine_activity)
[![Inline docs](http://inch-ci.org/github/emsk/redmine_activity.svg?branch=master)](http://inch-ci.org/github/emsk/redmine_activity)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)

Summarize one day's activities on Redmine.

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
Example Project - 機能 #2 (新規): チケット２ (2016-01-23T13:45:12Z)
Example Project - 機能 #1 (新規): チケット１ (2016-01-23T12:34:56Z)
```

Print yesterday's activities:

```sh
$ redmine_activity yesterday --url=http://example.com/redmine --login-id=admin --password=pass
```

Print one day's activities:

```sh
$ redmine_activity --date=2016-01-01 --url=http://example.com/redmine --login-id=admin --password=pass
```

Run `redmine_activity help` for more details.

## ENV

| ENV Variable | Description |
| :----------- | :---------- |
| `REDMINE_ACTIVITY_URL` | Redmine URL |
| `REDMINE_ACTIVITY_LOGIN_ID` | Redmine login ID |
| `REDMINE_ACTIVITY_PASSWORD` | Redmine password |

You can execute the command without passing options.

## Documentation

http://www.rubydoc.info/github/emsk/redmine_activity

## Development

WIP

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/emsk/redmine_activity.

## License

[MIT](LICENSE.txt)
