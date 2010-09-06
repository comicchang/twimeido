module TwiMeido
  module AccountCommands
    extend Command

    define_command :oauth, /^-oauth$/ do |user, message|
      client = TwitterOAuth::Client.new(
        :consumer_key => AppConfig.twitter.consumer_key,
        :consumer_secret => AppConfig.twitter.consumer_secret
      )
      request_token = client.request_token(
        :oauth_callback => 'oob'
      )
      user.update(
        :request_token => request_token.token,
        :request_token_secret => request_token.secret
      )

      <<-MESSAGE
Please visit the following URL to confirm your OAuth request:
#{request_token.authorize_url}
After that you'll get a PIN code, use it with -bind command to complete the OAuth process like this:
-bind PIN_CODE
      MESSAGE
    end

    define_command :bind, /^-bind\s*(.+)$/ do |user, message, params|
      begin
        client = TwitterOAuth::Client.new(
          :consumer_key => AppConfig.twitter.consumer_key,
          :consumer_secret => AppConfig.twitter.consumer_secret
        )
        access_token = client.authorize(
          user.request_token,
          user.request_token_secret,
          :oauth_verifier => params[1]
        )
        account = Hashie::Mash.new(client.info)
        user.update(
          :twitter_user_id => account.id,
          :screen_name => account.screen_name,
          :oauth_token => access_token.token,
          :oauth_token_secret => access_token.secret
        )

        TwitterStream.options[:filters] << user.screen_name
        TwitterStream.immediate_reconnect

      rescue OAuth::Unauthorized
        return 'OAuth with Twitter failed, please retry by use -oauth command.'
      end

      <<-MESSAGE
Successfully bound your Twitter account, now you can:
* Use commands to access your Twitter account.
* Receive tweets which contain your username nearly real-time.
* Tweet to Twitter by directly send your tweets.
      MESSAGE
    end

    define_command :on, /^-on$/ do |user, message|
      if TwitterStream.options[:filters].include?(user.screen_name)
        'Real-time notification already turned on, ご主人様.'
      else
        TwitterStream.options[:filters] << user.screen_name
        TwitterStream.immediate_reconnect
        'Real-time notification turned on, ご主人様.'
      end
    end

    define_command :off, /^-off$/ do |user, message|
      if TwitterStream.options[:filters].include?(user.screen_name)
        TwitterStream.options[:filters].delete user.screen_name
        TwitterStream.immediate_reconnect
        'Real-time notification turned off, ご主人様.'
      else
        'Real-time notification already turned off, ご主人様.'
      end
    end
  end
end