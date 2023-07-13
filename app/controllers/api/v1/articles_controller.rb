class Api::V1::ArticlesController < SecuredController
  skip_before_action :authorize_request, only: %i[index show]
  def index
    @articles = Article.all.includes(:user).all
    render json: {
      data: @articles.as_json(include: [{ user: { only: [:id, :avatar] } }])
    }
  end

  def show
    @article = Article.includes(:user).find(params[:id])
    render json: {
      data: @article.as_json(include: [{ user: { only: [:id, :avatar] } }])
    }
  end

  def create
    @article = @current_user.articles.build(article_params)
    logger.debug(@article.inspect)
    if @article.save
      render json: {
        data: @article.as_json(include: [{ user: { only: [:id, :avatar] } }])
      }
    else
      render_400(nil, @article.errors.full_messages)
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :picture, :piety_category_id, :piety_target_id, :cost, :days)
  end
end
