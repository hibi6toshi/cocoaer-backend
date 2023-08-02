class Api::V1::ArticlesController < SecuredController
  skip_before_action :authorize_request, only: %i[index show]

  include Api::Pagination

  def index
    @articles = Article.all.includes(:user, :favorited_by_users).order(created_at: :desc).page(params[:page])
    render json: {
      data: @articles.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids),
      pagination_info: pagination_info(@articles)
    }
  end

  def show
    @article = Article.includes(:user, :favorited_by_users).find(params[:id])
    render json: {
      data: @article.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
    }
  end

  def create
    @article = @current_user.articles.build(article_params)
    logger.debug(@article.inspect)
    if @article.save
      render json: {
        data: @article.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
      }
    else
      render_400(nil, @article.errors.full_messages)
    end
  end

  def edit
    @article = @current_user.articles.find(params[:id])
    render json: {
      data: @article.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
    }
  end

  def update
    @article = @current_user.articles.find(params[:id])
    if @article.update(article_params)
      render json: {
        data: @article.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
      }
    else
      render_400(nil, @article.errors.full_messages)
    end
  end

  def destroy
    @article = @current_user.articles.find(params[:id]).destroy!
    render json: {
      data: @article.as_json
    }
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :picture, :piety_category_id, :piety_target_id, :cost, :days)
  end
end
