require 'rails_helper'

feature 'Projects CRUD' do
  scenario 'Users can see a list of project names and create new project' do
    sign_in_user

    project = Project.new(name: "Super Cool Project")
    project.save!
    visit projects_path

    within '.dropdown-menu'  do
      click_on 'New Project'
    end


    click_link 'New Project'

    expect(page).to have_content "New Project"
    fill_in "Name", with: "Knit Socks"
    click_button 'Create Project'
  end

  scenario 'User can edit projects' do
    user = create_user
    sign_in_user(user)
    project = Project.new(name: "Knit Socks")
    project.save!

    create_membership(user_id: user.id, project_id: project.id, role: "Owner")

    visit edit_project_path(project)
    fill_in "Name", with: "knit more socks"
    click_button 'Update Project'
  end

  scenario 'display error messages and validate task fields' do
    sign_in_user
    visit new_project_path

    click_button 'Create Project'
    expect(page).to have_content "1 error prohibited this form from being saved:"
  end
end

feature "projects can only be managed by project owners" do
  scenario "non project owner does not see edit button or delete button for projects" do
    project = create_project
    non_owner_user = create_user
    create_membership(project_id: project.id, user_id: non_owner_user.id, role: "Member")

    sign_in_user(non_owner_user)

    visit project_path(project)

    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete")
  end

  scenario "non project owner gets redirected when trying to visit the edit project page" do
    project = create_project
    user = create_user
    sign_in_user(user)

    visit edit_project_path(project)

    expect(page).to have_content("You do not have access")
  end
end
