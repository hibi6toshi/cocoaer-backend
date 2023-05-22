class Api::V1::ForumsController < SecuredController
  skip_before_action :authorize_request, only: %i[index]

  def index
    logger.debug("forums_index")
    @forums = Forum.includes(:user).all
    # render json: @forums.to_json(include: [{ user: { only: [:id, :avatar] } }])


    render json: {
      data: @forums.as_json(include: [{ user: { only: [:id, :avatar] } }])
    }
  end
end
