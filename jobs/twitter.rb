require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
Twitter.configure do |config|
  config.consumer_key = 'qFudt8oIE2MVJHcLW2QaEQ'
  config.consumer_secret = 'E3NEw0DYtKhXogjM92YoXVvKB4OW5lJoMQXqDlCRes'
  config.oauth_token = '14381641-MSJpMPm0v8e3UI4mU7q5GtqCgNYjhkOINCFMlZ65J'
  config.oauth_token_secret = 'UFqMEgz57RZ7TEYqOCp37uO8ltFZwTTFZcb5WcJkMZvuL'
end

search_term = URI::encode('#sto')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = Twitter.search("#{search_term}").results

    if tweets
      tweets.map! do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end