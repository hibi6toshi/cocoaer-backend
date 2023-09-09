class Api::V1::ProjectsController < SecuredController
  skip_before_action :authorize_request, only: %i[index]

  include Api::Pagination

  def index
    @q = Project.ransack(params[:q])

    @projects = @q.result(distinct: true).includes(:user, :favorited_by_users).all.order(created_at: :desc).page(params[:page])
    render json: {
      data: @projects.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids),
      pagination_info: pagination_info(@projects),
      q: params[:q]
    }
  end

  def show
    @project = Project.includes(:user, :tasks, :actions, :favorited_by_users).find(params[:id])

    render json: {
      data: @project.as_json(include: [{ user: { only: [:id, :avatar, :name] } }, { tasks: { only: [:id, :name] } }, { actions: { only: [:id, :name] } }], methods: :favorited_by_user_ids)
    }
  end

  def create
    @project = @current_user.projects.new
    @project_form = ProjectForm.new(@project)
    if @project_form.save(project_form_params)
      render json: {
        data: @project.as_json(include: [{ user: { only: [:id, :avatar, :name] } }], methods: :favorited_by_user_ids)
      }
    else
      render_400(nil, @project_form.errors.full_messages)
    end
  end

  def edit
    @project = @current_user.projects.includes(:user, :tasks, :actions).find(params[:id])
    render json: {
      data: @project.as_json(include: [{ user: { only: [:id, :avatar, :name] } }, { tasks: { only: [:id, :name] } }, { actions: { only: [:id, :name] } }])
    }
  end

  def update
    @project = @current_user.projects.find(params[:id])
    @project_form = ProjectForm.new(@project)
    if @project_form.save(project_form_params)
      render json: {
        data: @project.as_json(include: [{ user: { only: [:id, :avatar, :name] } }])
      }
    else
      render_400(nil, @project_form.errors.full_messages)
    end
  end

  def destroy
    @project = @current_user.projects.find(params[:id]).destroy!
    render json: {
      data: @project.as_json
    }
  end

  private

  def project_form_params
    params.require(:project_form).permit(:title, :body, :piety_category_id, :piety_target_id, :limit_day, :cost, :tasks, :actions)
  end
end
