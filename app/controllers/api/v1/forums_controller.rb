class Api::V1::ForumsController < SecuredController
  skip_before_action :authorize_request, only: %i[index]

  include Api::Pagination

  def index
    @q = Forum.ransack(params[:q])

    @forums = @q.result(distinct: true).includes(:user, :favorited_by_users).all.order(created_at: :desc).page(params[:page])
    render json: {
      data: @forums.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids),
      pagination_info: pagination_info(@forums),
      q: params[:q]
    }
  end

  def show
    @forum = Forum.includes(:user, :favorited_by_users).find(params[:id])

    render json: {
      data: @forum.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
    }
  end

  def create
    @forum = @current_user.forums.build(forums_param)
    if @forum.save
      render json: {
        data: @forum.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
      }
    else
      render_400(nil, @forum.errors.full_messages)
    end
  end

  def edit
    @forum = @current_user.forums.find(params[:id])
    render json: {
      data: @forum.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
    }
  end

  def update
    @forum = @current_user.forums.find(params[:id])

    if @forum.update(forums_param)
      render json: {
        data: @forum.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
      }
    else
      render_400(nil, @forum.errors.full_messages)
    end
  end

  def destroy
    @forum = @current_user.forums.find(params[:id]).destroy!

    render json: {
      data: @forum.as_json
    }
  end

  private

  def forums_param
    params.require(:forum).permit(:title, :body, :picture, :piety_category_id, :piety_target_id, :cost, :days)
  end
end
