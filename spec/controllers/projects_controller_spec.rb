require "rails_helper"

  describe ProjectsController do

    before :each do
      @user = create_user
      session[:user_id] = @user.id
      @project = create_project
    end

    describe 'GET #index' do
      it 'renders the project index view' do
        Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')

        get :index

        expect(response).to render_template :index
        expect(assigns(:projects)).to eq [@project]
    end
  end

  describe 'Permissions' do
    it "adds current_user as project owner after creating a project" do

      get :new

      expect {
        post :create, project: { name: "Knit Socks"}
      }.to change {Project.all.count}.by(1)

      expect(Membership.last.role).to eq "Owner"
    end
  end

  describe 'GET #show' do
    it 'displays project show page for project member' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')


      get :show, id: @project.id

      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it 'allows project owner to edit project' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Owner')

      get :edit, id: @project.id

      expect(response).to render_template :edit
      expect(assigns(:project)).to eq @project
    end

    it 'does not allow project member to edit project' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')

      get :edit, id: @project.id

      expect(response).to redirect_to project_path(@project)
      expect(flash[:warning]).to eq 'You do not have access'
    end
  end

  describe 'PATCH #update' do
    it 'allows project owner to update project' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Owner')

      expect{
        patch :update, id: @project.id, project: {name: "Build a fort"}
      }.to change{@project.reload.name}.from('Test Project').to('Build a fort')

      expect(response).to redirect_to project_path(@project)
      expect(flash[:notice]).to eq 'Project was successfully updated'
    end
  end

  describe 'DELETE #destroy' do
    it 'allows project owner to delete a project' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Owner')

      expect{
        delete :destroy, id: @project.id
      }.to change {Project.all.count}.by(-1)

      expect(flash[:notice]).to eq 'Project was successfully deleted'
      expect(response).to redirect_to projects_path

    end

    it 'allows admin to delete a project' do
      session.clear
      user = create_user(admin: true)
      session[:user_id] = user.id


      expect{
        delete :destroy, id: @project.id
      }.to change {Project.all.count}.by(-1)

      expect(flash[:notice]).to eq 'Project was successfully deleted'
      expect(response).to redirect_to projects_path
    end

    it 'doesn\'t allow members of projects to delete projects' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')

      expect {
        delete :destroy, id: @project.id
      }.to_not change {Project.all.count}
    end
  end

end
