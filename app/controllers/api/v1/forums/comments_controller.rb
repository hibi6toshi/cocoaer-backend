class Api::V1::Forums::CommentsController < SecuredController
  include Api::Commentable

  skip_before_action :authorize_request, only: %i[index]

  private

  def set_commentable
    @commentable = Forum.find(params[:forum_id])
  end
end
