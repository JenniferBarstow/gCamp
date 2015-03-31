class ProjectsController < PrivateController
  before_action :set_project, only:[:show, :edit, :update, :destroy]
  before_action :is_project_member_or_admin?, only: [:show, :update, :destroy]
  before_action :ensure_project_owner, only: [:edit, :destroy, :update]

  def index
    @projects = current_user.projects
    @admin_projects = Project.all
    tracker_api = TrackerAPI.new
    if current_user.pivotal_tracker_token
      @tracker_projects = tracker_api.projects(current_user.pivotal_tracker_token)
    end
  end

  def new
    @project = Project.new
  end

  def create
    project = Project.new(project_params)
    if project.save
      membership = project.memberships.create!(user_id: current_user.id, role: "Owner")
      redirect_to project_tasks_path(project)
      flash[:success] = "Project was successfully created"
    else
      @project = project
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated"
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "Project was successfully deleted"
    redirect_to projects_path
    end
  end

  private
  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def ensure_project_owner
    project = Project.find(params[:id])
    unless project.is_admin_owner?(current_user)
      flash[:warning] = "You do not have access"
      redirect_to project_path(project)
    end
  end

  def is_project_member_or_admin?
    if !current_user.admin_or_member(@project)
      flash[:warning] = "You do not have access to that project"
      redirect_to projects_path
    end
  end
end
