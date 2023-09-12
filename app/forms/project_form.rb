class ProjectForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :title, :body, :piety_category_id, :piety_target_id, :limit_day, :cost, :tasks, :actions

  validates :title, :body, :piety_category_id, :piety_target_id, presence: true
  validates :title, length: { maximum: 30 }

  def initialize(project)
    super()
    @project = project
    @user = project.user
  end

  def save(params)
    assign_attributes(params)
    return false unless valid?

    set_project_value
    @project.save
  end

  private

  def set_project_value
    @project.title = title
    @project.body = body
    @project.piety_category_id = piety_category_id
    @project.piety_target_id = piety_target_id
    @project.limit_day = limit_day
    @project.cost = cost
    @project.tasks = JSON.parse(tasks).map { |task| @user.tasks.build(name: task['name']) }
    @project.actions = JSON.parse(actions).map { |action| @user.actions.build(name: action['name']) }
  end
end
