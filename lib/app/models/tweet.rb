# encoding: utf-8
class Tweet
  include MongoMapper::Document

  key :_id, Integer
  key :entities, Hashie::Mash
  key :user, Hashie::Mash
  key :retweeted_status, Hashie::Mash
  key :geo, Hashie::Mash

  class << self
    def fetch(id)
      Tweet.find(id) || Tweet.create(
        TwiMeido.current_user.rest_api_client.statuses.show._(id).json?
      )
    rescue
    end
  end
end
