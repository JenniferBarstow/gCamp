
require 'rails_helper'


feature 'Users CRUD' do
 scenario 'Users can see a list of users names and emails' do
   sign_in_user


    user = User.new(first_name: "Steve", last_name: "H", email: "steve@gmail.com", password: "password", password_confirmation: "password")
    user.save!

   visit users_path
   expect(page).to have_content "Steve H"
   expect(page).to have_content "steve@gmail.com"

   click_link 'New User'

   expect(page).to have_content "New User"
   fill_in "First Name", with: "John"
   fill_in "Last Name", with: "Smith"
   fill_in "Email", with: "john@smith.com"
   fill_in "Password", with: "password"
   fill_in "Password Confirmation", with: "password"
   click_button 'Create User'
 end

   scenario 'User can edit users' do
     sign_in_user
   user = User.new(first_name: "John", last_name: "Smith", email: "john@smith.com", password: "password", password_confirmation: "password" )
   user.save!

   visit edit_user_path(user)
   fill_in :user_first_name, with: "Johnny"
   fill_in :user_last_name, with: "Bravo"
   fill_in :user_email, with: "johnny@bravo.com"
   fill_in :user_password, with: "password1"
   fill_in :user_password_confirmation, with: "password1"

   click_button 'Update User'

 end

 scenario 'display error messages and validate user fields' do
   sign_in_user
   visit new_user_path

   click_button 'Create User'
   expect(page).to have_content "4 errors prohibited this form from being saved:"
 end
 end
