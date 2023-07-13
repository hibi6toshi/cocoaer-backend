class AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  def create_user
    @auth_payload, @auth_header = verify_token
    return if current_user

    @user = User.create_user_with_payload(@auth_payload)
  end

  def current_user
    @auth_payload, @auth_header = verify_token
    @user = User.from_token_payload(@auth_payload)
  end

  private

  def http_token
    @headers['Authorization'].split(' ').last if @headers['Authorization'].present?
  end

  def verify_token
    JsonWebToken.verify(http_token)
  end
end