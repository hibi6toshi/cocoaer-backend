class Api::V1::ArticlesController < SecuredController
  skip_before_action :authorize_request, only: %i[index show]
  def index
    @articles = Article.all.includes(:user).where
    render json: {
      data: @articles.as_json(include: [{ user: { only: [:id, :avatar] } }]),
    }
  end

  def show
    @article = Article.includes(:user).find(params[:id])
    render json: {
      data: @article.as_json(include: [{ user: { only: [:id, :avatar] } }])
    }
  end
end
