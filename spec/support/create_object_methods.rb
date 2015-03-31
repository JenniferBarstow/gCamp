  def create_user(options = {})
    User.create!({
      first_name: 'luke',
      last_name: 'skywalker',
      email: "luke#{rand(5000)+1}@skywalker.com",
      password: '1234',
      password_confirmation: '1234'
    }.merge(options))
  end

  def create_project(options = {})
    Project.create!({
      name: 'Test Project'
    }.merge(options))
  end

  def create_task(options = {})
    Task.create!({
      description: 'Test task for a project',
      project_id: 1,
      complete: true,
    }.merge(options))
  end

  def create_comment(options = {})
    Comment.create!({
      description: 'Test comment'
    }.merge(options))
  end

  def create_membership(options = {})
    Membership.create!({
      role: 'Member',
      project_id: create_project.id,
      user_id: create_user.id
    }.merge(options))
  end
