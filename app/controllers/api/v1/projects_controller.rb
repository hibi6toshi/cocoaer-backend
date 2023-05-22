class Api::V1::ProjectsController < SecuredController
  skip_before_action :authorize_request, only: %i[index show]

  def index
    @projects = Project.includes(:user).all
    render json: {
      data: @projects.as_json(include: [{ user: { only: [:id, :avatar] } }])
    }
  end
end
