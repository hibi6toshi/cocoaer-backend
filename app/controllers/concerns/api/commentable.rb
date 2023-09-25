module Api::Commentable
  extend ActiveSupport::Concern

  included do
    before_action :set_commentable, only: %i[index create]
  end

  def index
    @comments = @commentable.comments.includes(:user).order(created_at: :desc)
    render json: {
      data: @comments.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
    }
  end

  def create
    @comment = @current_user.comments.build(commentable: @commentable, body: params[:comment][:body])

    if @comment.save
      render json: {
        data: @comment.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
      }
    else
      render_400(nil, @commentable.errors.full_messages)
    end
  end

  def update
    @comment = @current_user.comments.find(params[:id])
    if @comment.update(comment_params)
      render json: {
        data: @comment.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
      }
    else
      render_400(nil, @comment.errors.full_messages)
    end
  end

  def destroy
    @comment = @current_user.comments.find(params[:id]).destroy!
    render json: {
      data: @comment.as_json
    }
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    raise NotImplementedError
  end
end
