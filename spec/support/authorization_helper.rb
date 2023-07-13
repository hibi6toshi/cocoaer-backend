module AuthorizationHelper
  def authorization_stub
    allow(AuthorizationService).to receive(:new).and_return(authorization_service)
    allow(authorization_service).to receive(:current_user).and_return(user)
  end
end