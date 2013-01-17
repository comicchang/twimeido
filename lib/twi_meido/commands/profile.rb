# encoding: utf-8
module TwiMeido
  module ProfileCommand
    extend Command

    REGEX_INNER = %r{[^/\\]*(?:\\.[^/\\]*)*(?:\[[^\]\\]*(?:\\.[^\]\\]*)*\][^/\\]*(?:\\.[^/\\]*)*)*}
    REGEX = %r{^s/(#{REGEX_INNER})/(#{REGEX_INNER})/(\w*)$}

    define_command :bio, /\Abio\s+(.+)\Z/i do |user, message, params|
      re = params[1]
      if not result = REGEX.match(re)
        raise 'Invalid s/// operator.'
      end
      match, replace, modifiers = result.captures

      gsub = modifiers.sub!('g', '')
      options = 0
      options |= Regexp::IGNORECASE if modifiers.sub!('i', '')
      options |= Regexp::EXTENDED   if modifiers.sub!('x', '')
      options |= Regexp::MULTILINE  if modifiers.sub!('m', '')
      if not modifiers.empty?
        raise 'Unknown regexp option.'
      end

      regexp = Regexp.new(match, options)
      profile = TwiMeido.current_user.rest_api_client.users.show? :screen_name => user.screen_name
      if gsub
        description = profile.description.gsub(regexp, replace)
      else
        description = profile.description.sub(regexp, replace)
      end
      TwiMeido.current_user.rest_api_client.account.update_profile! :description => description

      "Your bio has been changed to \"#{description}\", ご主人様."
    end
  end
end
