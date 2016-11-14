require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Nettoken < OmniAuth::Strategies::OAuth2
      # change the class name and the :name option to match your application name
      option :name, 'nettoken'

      option :client_options, {
        :site => "http://oauth.nettoken.co.uk",
        :authorize_url => "/oauth/authorize"
      }

      uid { raw_info["id"] }

      info do
        {
          :email => raw_info["email"]
          # and anything else you want to return to your API consumers
        }
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||= access_token.get('/api/me.json').parsed
      end
    end
  end
end
