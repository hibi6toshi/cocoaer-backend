class Api::V1::FavoritesController < SecuredController
  before_action :valid_param?, :set_favoritable, only: %i[create destroy]

  include Api::Pagination

  def index
    @favorites = @current_user.send("favorited_#{params[:favoritable_type].downcase}s").includes(:user, :favorited_by_users).order(created_at: :desc).page(params[:page])
    render json: {
      data: @favorites.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids),
      pagination_info: pagination_info(@favorites)
    }
  end

  def create
    @current_user.favorite(@favoritable)

    render json: {
      data: @favoritable.reload.as_json(include: [{ favorited_by_users: { only: [:id, :avatar] } }], methods: :favorited_by_user_ids)
    }
  end

  def destroy
    @current_user.unfavorite(@favoritable)

    render json: {
      data: @favoritable.reload.as_json(include: [{ favorited_by_users: { only: [:id, :avatar] } }], methods: :favorited_by_user_ids)
    }
  end

  private

  def valid_param?
    render_404 unless Favorite::FAVORITABLE_TYPES.include?(params[:favoritable_type])
  end

  def set_favoritable
    @favoritable = params[:favoritable_type].constantize.includes(:favorited_by_users).find(params[:favoritable_id])
  end
end
