class PrivateController < ApplicationController
  before_action :ensure_current_user

  def require_membership
    @project = Project.find(params[:id])

    unless @project.users.pluck(:id).include?(current_user.id)
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def require_ownership
    @project = Project.find(params[:id])

    unless @project.memberships.where(user_id: current_user.id).pluck(:role)==["Owner"]
      flash[:error] = "You do not have access"
      redirect_to project_path(@project)
    end
  end

  def is_user_or_admin?(user)
    user == current_user || current_user.admin
  end

  def verify_admin_or_owner

  end

  def ensure_project_owner_or_admin
    if !current_user.admin_or_owner?(@project)
      flash[:warning] = 'You do not have access'
      redirect_to projects_path
    end
  end

  def is_project_member_or_admin?
    if !current_user.admin_or_member(@project)
      flash[:warning] = "You do not have access to that project"
      redirect_to projects_path
    end
  end


  def current_user_not_permitted_access
    if !is_user_or_admin?(@user)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end
