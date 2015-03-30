class TasksController < PrivateController

  before_action :set_task, only: [:show, :edit, :update]
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :is_project_member_or_admin?

  def index
    @tasks = @project.tasks
  end

  def new
    @task = Task.new(:project_id => @project.id)
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def show
    @task = @project.tasks.find(params[:id])
    @comments = Comment.all
    @comment = Comment.new
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])

    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated"
      redirect_to project_task_path(@project, @task)
    else
      render :edit
    end
  end

  def destroy
    task = @project.tasks.find(params[:id])
    task.destroy
    flash[:notice] = "Task was successfully deleted"
    redirect_to project_tasks_path(@project)
  end

  private

  def task_params
    params.require(:task).permit(:description, :complete, :due_date).merge(:project_id => @project.id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
