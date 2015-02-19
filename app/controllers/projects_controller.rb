class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project was successfully created"
      redirect_to @project
    else
      @project = Project.new(project_params)
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
      project = Project.find(params[:id])
        if project.update
          flash[:notice] = "Project was successfully updated"
          redirect_to @project
        else
          render :edit
        end
      end

      def destroy
        project = Project.find(params[:id])
        project.destroy
        redirect_to projects_path
      end

    private
    def project_params
      params.require(:project).permit(:name)
    end
  end
