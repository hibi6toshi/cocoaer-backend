class Api::V1::User::ProjectsController < SecuredController
  def index
    @user = User.find(params[:user_id])
    @projects = @user.projects.includes(:user, :favorited_by_users).order(created_at: :desc)
    render json: {
      data: @projects.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
    }
  end
end
