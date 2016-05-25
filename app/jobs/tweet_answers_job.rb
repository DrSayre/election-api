class TweetAnswersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    donald = Candidate.find_by(name: 'Donald Trump')
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'u5vFeT4xtVC7AOmF9v7yaoMmy'
      config.consumer_secret     = 'pSgmbN6HNgyjjyTazIsKakeOVpxM2TLcBY3PEI2qNSHOxgIFnM'
      config.access_token        = '730462145473875968-Ly3TCjWJeUQAwSEbk4YaTJfQXKMo0t2'
      config.access_token_secret = 'Vl01D6ad9xHh9urdYIvKeCOSy1hkiX9QBPWH6NwWl8rwO'
    end
    client.search('#willtrumpwin -rt', result_type: 'recent').each do |tweet|
      already_tweeted = Tweet.where(identity: tweet.id).count > 0
      message = "@#{tweet.user.screen_name} #{donald.magic_8_ball} #willtrumpwin"
      if !already_tweeted && tweet.user.screen_name != 'willtrumpwin'
        if client.update(message, in_reply_to_status_id: tweet.id)
          Tweet.create(identity: tweet.id, content: message)
        end
      end
    end
    TweetAnswersJob.set(wait: 5.minutes).perform_now
  end
end
