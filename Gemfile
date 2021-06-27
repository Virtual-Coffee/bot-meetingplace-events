source "https://rubygems.org"
ruby File.read(".ruby-version").chomp

gem "activesupport"
gem "dotenv"
gem "dotiw"
gem "rake"
gem "slack-ruby-bot"
gem "zeitwerk"

group :test do
  gem "rack-test"
  gem "rspec"
  gem "simplecov", require: false
  gem "timecop"
  gem "vcr"
  gem "webmock"
end

group :development do
  gem "github_changelog_generator", "~> 1.16", require: false
  gem "standardrb", "~> 1.0", require: false
end
