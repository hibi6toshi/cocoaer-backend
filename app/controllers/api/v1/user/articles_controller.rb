class Api::V1::User::ArticlesController < SecuredController
  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles.includes(:user, :favorited_by_users)
    render json: {
      data: @articles.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
    }
  end
end
