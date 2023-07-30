class Api::V1::Projects::CommentsController < SecuredController
  # projectは一旦commentなし

  # skip_before_action :authorize_request, only: %i[index]
  # def index
  #   @comments = Project.find(params[:project_id]).comments.includes(:user).order(created_at: :desc)
  #   render json: {
  #     data: @comments.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
  #   }
  # end

  # def create
  #   @project = Project.find(params[:project_id])
  #   @comment = @current_user.comments.build(commentable: @project, body: params[:comment][:body])

  #   if @comment.save
  #     render json: {
  #       data: @comment.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
  #     }
  #   else
  #     render_400(nil, @project.errors.full_messages)
  #   end
  # end

  # def update
  #   @comment = @current_user.comments.find(params[:id])
  #   if @comment.update(comment_params)
  #     render json: {
  #       data: @comment.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
  #     }
  #   else
  #     render_400(nil, @comment.errors.full_messages)
  #   end
  # end

  # def destroy
  #   @comment = @current_user.comments.find(params[:id]).destroy!
  #   render json: {
  #     data: @comment.as_json
  #   }
  # end

  # private

  # def comment_params
  #   params.require(:comment).permit(:body)
  # end
end
