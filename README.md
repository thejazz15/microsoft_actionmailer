# MicrosoftActionmailer

Use Microsoft Graph API to send out emails with ActionMailer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'microsoft_actionmailer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install microsoft_actionmailer

## Usage

1. Set up `authorization` with an access token provided by [Microsoft Graph API](https://docs.microsoft.com/en-us/graph/auth-overview).

2. Once you have the authorization set up, modify the ActionMailer configuration in `config/environments/$ENVIRONMENT.rb`

```ruby
config.action_mailer.delivery_method = :microsoft_actionmailer

config.action_mailer.microsoft_actionmailer_settings = {
  authorization: ...,
  delivery_options: {
    before_send: ...,
    after_send: ...,
  }
}
```

### Options

| Option | Details |
| ------ | ------- |
| authorization | This is the access token as described in [Microsoft Graph API](https://docs.microsoft.com/en-us/graph/auth-v2-user) |
| delivery_options | This currently contains hooks for before the message is sent and after the message is sent. |

Since access tokens are usually short-lived, the **Dynamic Setting** of delivery method may be required:

```ruby
mail.delivery_method(
  MicrosoftActionmailer::DeliveryMethod, {
  authorization: ...
})
```

Normal ActionMailer usage will now transparently be sent using Microsoft's Graph API.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thejazz15/microsoft_actionmailer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MicrosoftActionmailer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/thejazz15/microsoft_actionmailer/blob/master/CODE_OF_CONDUCT.md).
