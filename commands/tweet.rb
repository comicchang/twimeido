module TwiMeido
  module TweetCommand
    extend Command

    define_command :tweet, /^.*$/ do |user, message|
      TwitterClient.statuses.update! :status => message.body.strip
      'Successfully tweeted, ご主人様.'
    end
  end
end