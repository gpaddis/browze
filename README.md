# Browze

A scraping-oriented browser-like wrapper around HTTParty for your cli tools.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'browze'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install browze

## Usage Examples

```ruby
# Instantiate the browser
browser = Browze.start

# By default the browser is instantiated with a desktop user agent. if you want
# to use a mobile user agent instead, start it with :mobile.
mobile_browser = Browze.start(:mobile)

# A random user agent is set automatically
# e.g.: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
browser.user_agent

# Set any custom headers
browser.headers = { foo: 'bar' }

# Perform a GET request
response = browser.get('https://www.google.com/')

# Return the parsed response body as a Nokogiri::HTML::Document
response.parsed

# Perform a POST request
browser.post(
  'https://www.example.com/url.php',
  param1: 'example',
  param2: 'example'
)

# Download a file and show a progress bar
browser.download('https://www.example.com/robots.txt')

# Show the current IP and geolocation
browser.ip       # => 75.152.126.127
browser.location # => Grande Prairie, Canada
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rspec` to run the specs or `bundle exec guard --clear` to keep them running during the development.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
