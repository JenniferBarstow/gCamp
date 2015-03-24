require 'rails_helper'


feature 'Tasks CRUD' do
  scenario 'Users can see tasks list with description and due date and create new task' do
    sign_in_user

    visit projects_path
    within '.dropdown-menu'  do
      click_on 'New Project'
    end

    click_link 'New Project'

    expect(page).to have_content "New Project"
    fill_in "Name", with: "Knit Socks"
    click_button 'Create Project'

    click_link 'New Task'

    expect(page).to have_content "New Task"
    fill_in "Description", with: "Hike"
    fill_in :task_due_date, with: "08/25/2015"
    click_button 'Create Task'
    expect(page).to have_content "Task was successfully created"

    click_on 'Edit'

    fill_in :task_description, with: "hike more!"
    fill_in :task_due_date, with: "10/25/2015"
    click_button 'Update Task'
    expect(page).to have_content "Task was successfully updated"
    expect(page).to have_content "Knit Socks"
    expect(page).to have_content 'hike more!'

    click_on "Tasks"
    page.find('.glyphicon-remove').click
    expect(page).to_not have_content 'hike more!'
    expect(page).to have_content 'Task was successfully deleted'
    end

    scenario 'display error messages and validate task fields' do
    user = create_user
    sign_in_user(user)

    project = create_project
    create_membership(project_id: project.id, user_id: user.id)

    visit new_project_task_path(project)

    click_button 'Create Task'
    expect(page).to have_content "1 error prohibited this form from being saved:"
  end
end
