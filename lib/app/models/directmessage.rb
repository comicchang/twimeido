# encoding: utf-8
class DirectMessage
  include MongoMapper::Document

  key :_id, Integer
  key :sender, Hashie::Mash

  class << self
    def fetch(id)
      DirectMessage.find(id) || DirectMessage.create(
        TwiMeido.current_user.rest_api_client.direct_messages.show._(id).json?
      )
    rescue
    end
  end
end
