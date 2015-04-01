require "rails_helper"

describe TasksController do

  before :each do
    @user = create_user
    session[:user_id] = @user.id
    @project = create_project
    @task = create_task(project_id: @project.id)
  end

  describe 'GET #index' do
    it 'allows project member to view list of tasks for that project' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')


      get :index, project_id: @project.id

      expect(response).to render_template :index
      expect(assigns(:tasks)).to eq [@task]
    end

    it 'does not allow non-members to view the tasks index' do

      get :index, project_id: @project.id

      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq 'You do not have access to that project'
    end

    it 'allows admin to view list of tasks for that project' do
      session.clear
      user = create_user(admin: true)
      session[:user_id] = user.id

      get :index, project_id: @project.id

      expect(response).to render_template :index
      expect(assigns(:tasks)).to eq [@task]
    end
  end

  describe 'GET #new' do
    it "assigns a new task " do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')

      get :new, project_id: @project.id

      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do
    it 'creates a new task' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')

      expect {
        post :create, task: { description: "Dance"}, project_id: @project.id
      }.to change {Task.all.count}.by(1)

      task = Task.last
      expect(response).to redirect_to project_task_path(@project, task)
      expect(flash[:notice]).to eq 'Task was successfully created'
    end

    it 'does not allow non-project members to create a new task' do

      expect {
        post :create, task: { description: "Knit Socks"}, project_id: @project.id
      }.to_not change {Task.all.count}

      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

    it 'allows admin to create a new task' do
      session.clear
      user = create_user(admin: true)
      session[:user_id] = user.id


      expect {
        post :create, task: { description: "Dance"}, project_id: @project.id
      }.to change {Task.all.count}.by(1)

      task = Task.last
      expect(response).to redirect_to project_task_path(@project, task)
      expect(flash[:notice]).to eq 'Task was successfully created'
    end
  end

  describe 'GET #edit' do
    it 'allows project member to edit tasks' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')

      get :edit, project_id: @project.id, id: @task.id

      expect(response).to render_template :edit
      expect(assigns(:task)).to eq @task
    end

    it 'does not allow non-project members to edit tasks' do

      get :edit, project_id: @project.id, id: @task.id

      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

    it 'allows admin to edit a task' do
      session.clear
      user = create_user(admin: true)
      session[:user_id] = user.id

      get :edit, project_id: @project.id, id: @task.id

      expect(response).to render_template :edit
      expect(assigns(:task)).to eq @task
    end
  end

  describe 'PATCH #update' do
    it 'allows project members to update a task' do
      Membership.create(user_id: @user.id, project_id: @project.id, role: 'Member')

      expect{
        patch :update, project_id: @project.id, id: @task.id, task: {description: "Do NOT dance"}
      }.to change{@task.reload.description}.from('Test task for a project').to('Do NOT dance')

      expect(response).to redirect_to project_task_path(@project, @task)
      expect(flash[:notice]).to eq 'Task was successfully updated'
    end

    it 'does not allow a non-project member to update a task' do

      expect {
        post :create, task: { description: "Knit Socks"}, project_id: @project.id
      }.to_not change {Task.all.count}

      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

  end
end
