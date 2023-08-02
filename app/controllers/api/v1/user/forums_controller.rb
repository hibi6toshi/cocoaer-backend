class Api::V1::User::ForumsController < SecuredController
  def index
    @user = User.find(params[:user_id])
    @forums = @user.forums.includes(:user, :favorited_by_users).order(created_at: :desc)
    render json: {
      data: @forums.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
    }
  end
end
