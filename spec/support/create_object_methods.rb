  def create_user(options = {})
    User.create!({
      first_name: 'luke',
      last_name: 'skywalker',
      email: 'luke@skywalker.com',
      password: '1234',
      password_confirmation: '1234'
    }.merge(options))
  end

  def create_project(options = {})
    Project.create!({
      name: 'Test Project'
    }.merge(options))
  end

  def create_task(project, options = {})
    Task.create!({
      description: 'Test task for a project',
      project_id: project.id,
      complete: true,
    }.merge(options))
  end
