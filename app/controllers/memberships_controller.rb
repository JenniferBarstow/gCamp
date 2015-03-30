class MembershipsController < PrivateController
  before_action :find_and_set_project
  before_action :set_membership, only: [:update, :destroy]
  before_action :verify_min_one_owner, only: [:update, :destroy]
  before_action :ensure_admin_owner_or_self, only:[:destroy]
  before_action :verify_admin_or_owner, only: [:edit, :update, :destroy]
  before_action :ensure_membership

  def index
    @membership = @project.memberships.new
  end

  def create
    membership = @project.memberships.new(membership_params)
    if membership.save
      flash[:notice] = "#{membership.user.full_name} was successfully added"
      redirect_to project_memberships_path(@project)
    else
      @membership = membership
      render :index
    end
  end

  def update
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path(@project)
    else
      @membership = membership
      render :index
    end
  end

  def destroy
    if current_user.id == @membership.user_id
      @membership.destroy
      flash[:notice] = "#{@membership.user.full_name} was successfully removed"
      redirect_to projects_path
    else
      @membership.destroy
      redirect_to project_memberships_path(@project)
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def find_and_set_project
    @project = Project.find(params[:project_id])
  end

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def verify_min_one_owner
    if @membership.role == "Owner" && @project.memberships.where(role: "Owner").count <= 1
      flash[:warning] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@membership.project_id)
    end
  end

  def ensure_admin_owner_or_self
    if !(@project.is_admin_owner?(current_user) || current_user.id == @membership.user_id)
      flash[:warning] = "You do not have access"
      redirect_to projects_path
    end
  end

  def ensure_membership
    unless @project.has_membership?(current_user)
      flash[:warning] = "You do not have access to that project"
      redirect_to projects_path
    end
  end
end
