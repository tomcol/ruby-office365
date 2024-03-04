# frozen_string_literal: true

module Office365
  module REST
    module Token
      def authorize_url
        base_uri = [LOGIN_HOST, "/#{tenant_id}/oauth2/v2.0/authorize"].join
        azure_params = {
          client_id: client_id,
          client_secret: client_secret,
          scope: Office365::SCOPE,
          response_type: "code",
          response_mode: "query",
          redirect_uri: redirect_uri,
          state: SecureRandom.hex
        }.ms_hash_to_query

        [base_uri, "?", azure_params].join
      end

      def token_url
        [LOGIN_HOST, "/#{tenant_id}/oauth2/v2.0/token"].join
      end

      def refresh_token!
        Models::AccessToken.new(
          Request.new(nil, debug: debug).post_no_auth_header(token_url, token_params)
        )
      end

      def cc_token!
        Models::AccessToken.new(
          Request.new(nil, debug: debug).post_no_auth_header(token_url, cc_token_params)
        )
      end

      def ropc_token!
        Models::AccessToken.new(
          Request.new(nil, debug: debug).post_no_auth_header(token_url, ropc_token_params)
        )
      end

      private

      def token_params
        {
          refresh_token: refresh_token,
          client_id: client_id,
          client_secret: client_secret,
          grant_type: "refresh_token"
        }
      end

      def cc_token_params
        {
          client_id: client_id,
          scope: 'https://graph.microsoft.com/.default',
          client_secret: client_secret,
          grant_type: "client_credentials"
        }
      end

      def ropc_token_params
        {
          client_id: client_id,
          grant_type: "password",
          # scope: Office365::SCOPE,
          # scope: 'Application.ReadWrite.All',
          scope: 'https://graph.microsoft.com/.default',
          # scope: "Contacts.ReadWrite Contacts.ReadWrite.Shared MailboxSettings.ReadWrite User.Read.All profile openid email",
          # scope: "Contacts.ReadWrite User.Read.All",
          username: delegate_user_name,
          password: delegate_password
        }
      end
    end
  end
end
