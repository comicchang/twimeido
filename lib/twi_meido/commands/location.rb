module TwiMeido
  module LocationCommands
    extend Command

    define_command :latitude_oauth, /\Alatitude\s+oauth\Z/i do |user, message|
      redirect = 'https://accounts.google.com/o/oauth2/auth?client_id=' + AppConfig.google.client_id + '&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/latitude.current.best&response_type=code'

      <<-MESSAGE
Please visit the following URL to confirm your OAuth request:
#{Googl.shorten(redirect).short_url}
After that you'll get a PIN code, use it with -latitude bind command to complete the OAuth process like this:
-latitude bind PIN_CODE
      MESSAGE
    end

    define_command :latitude_bind, /\Alatitude\s+bind\s+(.+)\Z/i do |user, message, params|
      begin
        code = params[1].to_s.strip

        uri = URI.parse 'https://accounts.google.com/o/oauth2/token'
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new uri.request_uri
        req.set_form_data({
          :client_id => AppConfig.google.client_id,
          :client_secret => AppConfig.google.client_secret,
          :code => code,
          :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob',
          :grant_type => 'authorization_code'
        })
        res = http.request(req)
        res.value
        res = Hashie::Mash.new(JSON.parse(res.body))
        user.update_attributes(
          :latitude_access_token => res.access_token,
          :latitude_created_at => Time.now,
          :latitude_expires_in => res.expires_in,
          :latitude_refresh_token => res.refresh_token
        )
        response = <<-MESSAGE
Successfully bound your Google Latitude, use -latitude on to send tweets with geo-location, ご主人様.
        MESSAGE
      rescue # Net::HTTPUnauthorized
        response = 'OAuth with Google Latitude failed, please retry by use -latitude oauth command, ご主人様.'
      end

      response
    end

    define_command :latitude_switch, /\Alatitude\s+(on|off)\Z/i do |user, message, params|
      if user.latitude_access_token == nil
        response = 'Please run -latitude oauth first, ご主人様.'
      elsif params[1] == 'on'
        user.update_attributes :latitude_on => 1
        response = 'Latitude location turned on, ご主人様.'
      else
        user.update_attributes :latitude_on => 0
        response = 'Latitude location turned off, ご主人様.'
      end

      response
    end
  end
end
