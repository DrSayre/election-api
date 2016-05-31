class TweetStatusJob < ApplicationJob
  queue_as :default

  def perform(*args)
    donald = Candidate.find_by(name: 'Donald Trump')
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'u5vFeT4xtVC7AOmF9v7yaoMmy'
      config.consumer_secret     = 'pSgmbN6HNgyjjyTazIsKakeOVpxM2TLcBY3PEI2qNSHOxgIFnM'
      config.access_token        = '730462145473875968-Ly3TCjWJeUQAwSEbk4YaTJfQXKMo0t2'
      config.access_token_secret = 'Vl01D6ad9xHh9urdYIvKeCOSy1hkiX9QBPWH6NwWl8rwO'
    end
    client.update("Donald Trump currently has a #{(donald.probability * 100).round(1)}\% chance of winning the election #WillTrumpWin")
    TweetStatusJob.set(wait: 6.hours).perform_now
  end
end
