require 'rails_helper'


feature 'Projects CRUD' do
 scenario 'Users can see a list of project names and create new project' do
   sign_in_user


    project = Project.new(name: "Super Cool Project")
    project.save!
    visit projects_path
    expect(page).to have_content "Super Cool Project"


   click_link 'New Project'

   expect(page).to have_content "New Project"
   fill_in "Name", with: "Knit Socks"
   click_button 'Create Project'
 end

   scenario 'User can edit projects' do
     sign_in_user
   project = Project.new(name: "Knit Socks")
   project.save!

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
