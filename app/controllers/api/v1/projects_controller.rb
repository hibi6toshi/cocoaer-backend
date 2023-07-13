class Api::V1::ProjectsController < SecuredController
  skip_before_action :authorize_request, only: %i[index]

  def index
    @projects = Project.includes(:user).all
    render json: {
      data: @projects.as_json(include: [{ user: { only: [:id, :avatar] } }])
    }
  end

  def show
    @projects = Project.includes(:user, :tasks, :actions).find(params[:id])

    render json: {
      data: @projects.as_json(include: [{ user: { only: [:id, :avatar] } }, { tasks: { only: [:id, :name] } }, { actions: { only: [:id, :name] } }])
    }
  end

  def create
    @project = @current_user.projects.new
    @project_form = ProjectForm.new(@project)
    if @project_form.save(project_form_params)
      render json: {
        data: @project.as_json(include: [{ user: { only: [:id, :avatar] } }])
      }
    else
      render_400(nil, @project_form.errors.full_messages)
    end
  end
  #   @project = @current_user.projects.build(projects_params)
  #   @project.tasks = JSON.parse(params[:project][:tasks]).map { |task| @current_user.tasks.build(name: task['name']) }
  #   @project.actions = JSON.parse(params[:project][:actions]).map { |action| @current_user.actions.build(name: action['name']) }
  #   # debugger

  #   if @project.save
  #     render json: {
  #       data: @project.as_json(include: [{ user: { only: [:id, :avatar] } }])
  #     }
  #   else
  #     render_400(nil, @project.errors.full_messages)
  #   end
  # end

  private

  # def projects_params
  #   # params.require(:project).permit(:title, :body, :piety_category_id, :piety_target_id, :limit_day, :cost, tasks: [:id, :user_id, :project_id, :name], actions: [:id, :user_id, :project_id, :name])
  #   params.require(:project).permit(:title, :body, :piety_category_id, :piety_target_id, :limit_day, :cost, tasks: [:id, :user_id, :project_id, :name], actions: [:id, :user_id, :project_id, :name])
  # end

  def project_form_params
    params.require(:project_form).permit(:title, :body, :piety_category_id, :piety_target_id, :limit_day, :cost, :tasks, :actions)
  end
end
