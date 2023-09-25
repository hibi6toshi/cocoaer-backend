class Api::V1::Articles::CommentsController < SecuredController
  include Api::Commentable

  skip_before_action :authorize_request, only: %i[index]

  private

  def set_commentable
    @commentable = Article.find(params[:article_id])
  end
end
