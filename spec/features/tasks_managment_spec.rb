require 'rails_helper'


feature 'Tasks CRUD' do
  scenario 'Users can see tasks list with description and due date and create new task' do
    sign_in_user

    project = create_project

   visit project_tasks_path(project)
   expect(page).to have_content project.name

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

   visit project_tasks_path(project)
   expect(page).to have_content project.name
   expect(page).to have_content 'hike more!'


   first('.glyphicon-remove').click
   expect(page).to_not have_content 'hike more!'
   expect(page).to have_content 'Task was successfully deleted'




  #  save_and_open_page

 end

 scenario 'display error messages and validate task fields' do
   sign_in_user

   project = create_project

   visit new_project_task_path(project)

   click_button 'Create Task'
   expect(page).to have_content "1 error prohibited this form from being saved:"
 end
 end
