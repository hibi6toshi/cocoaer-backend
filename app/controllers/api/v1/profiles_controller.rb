class Api::V1::ProfilesController < SecuredController
  def show
    render json: { data: @current_user.as_json(only: [:id, :avatar, :name, :introduction]) }
  end

  def update
    @current_user.update(profile_params)
    render json: { data: @current_user.reload.as_json(only: [:id, :avatar, :name, :introduction]) }
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :introduction, :avatar)
  end
end
