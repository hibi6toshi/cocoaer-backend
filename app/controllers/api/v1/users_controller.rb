class Api::V1::UsersController < ApplicationController
  def create
    authorize_request = AuthorizationService.new(request.headers)
    user = authorize_request.current_user
    user ||= authorize_request.create_user(params[:name])
    render json: { data: user.as_json(only: [:id, :avatar, :name]) }
  end

  def show
    @user = User.find(params[:id])
    render json: { data: @user.as_json(only: [:id, :avatar, :name, :introduction]) }
  end
end
