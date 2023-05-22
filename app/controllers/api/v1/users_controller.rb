class Api::V1::UsersController < SecuredController
  def create
    render json: "create_user"
  end
end
