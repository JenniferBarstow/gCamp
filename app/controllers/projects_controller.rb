class ProjectsController < PrivateController

  def index
    @projects = Project.all
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
      @project = Project.find(params[:id])
    end

    def edit
      @project = Project.find(params[:id])
    end

    def update
      @project = Project.find(params[:id])
      if @project.update(project_params)
        flash[:notice] = "Project was successfully updated"
        redirect_to project_path(@project)
      else
        render :edit
      end
    end

      def destroy
        project = Project.find(params[:id])
        if project.destroy
          flash[:notice] = "Project was successfully deleted"
        redirect_to projects_path
        end
      end

    private
    def project_params
      params.require(:project).permit(:name)
    end
  end
