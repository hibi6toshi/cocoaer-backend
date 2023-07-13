class Api::V1::ForumsController < SecuredController
  skip_before_action :authorize_request, only: %i[index]

  def index
    @forums = Forum.includes(:user).all
    # render json: @forums.to_json(include: [{ user: { only: [:id, :avatar] } }])

    render json: {
      data: @forums.as_json(include: [{ user: { only: [:id, :avatar] } }])
    }
  end

  def show
    @forum = Forum.includes(:user).find(params[:id])

    render json: {
      data: @forum.as_json(include: [{ user: { only: [:id, :avatar] } }])
    }
  end

  def create
    @forum = @current_user.forums.build(forums_param)
    if @forum.save
      render json: {
        data: @forum.as_json(include: [{ user: { only: [:id, :avatar] } }])
      }
    else
      render_400(nil, @forum.errors.full_messages)
    end
  end

  private

  def forums_param
    params.require(:forum).permit(:title, :body, :picture, :piety_category_id, :piety_target_id, :cost, :days)
  end
end
