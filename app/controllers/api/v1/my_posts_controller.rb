class Api::V1::MyPostsController < SecuredController
  before_action :valid_param?

  def show
    @myposts = @current_user.send("#{params[:content_type].downcase}s").includes(:user, :favorited_by_users).order(created_at: :desc)
    render json: {
      data: @myposts.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
    }
  end

  private

  def valid_param?
    render_404 unless %w[Article Project Forum].include?(params[:content_type])
  end
end
