module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module AuthHelpers
    def auth_request(user)
      sign_in user
      request.headers.merge!(user.create_new_auth_token)
    end
  end

end