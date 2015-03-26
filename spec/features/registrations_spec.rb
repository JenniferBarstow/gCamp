require 'rails_helper'

feature 'User should be able to log into gCamp and access other pages' do

  scenario 'should be able to login to gCamp from the welcome page' do
    visit root_path
    click_on 'Sign Up'
    fill_in 'First Name', with: 'Bruce'
    fill_in 'Last Name', with: 'Wayne'
    fill_in 'Email', with: 'brucewayne@batman.com'
    fill_in 'Password', with: 'robin'
    fill_in 'Password Confirmation', with: 'robin'
    within '.form' do
      click_on 'Sign Up'
    end
    within '.alert-success' do
      expect(page).to have_content 'You have successfully signed up'
    end
  end

  scenario 'should redirect user to root path when signing up' do
    visit root_path
    click_on 'Sign Up'
    fill_in 'First Name', with: 'Bruce'
    fill_in 'Last Name', with: 'Wayne'
    fill_in 'Email', with: 'brucewayne@batman.com'
    fill_in 'Password', with: 'robin'
    fill_in 'Password Confirmation', with: 'robin'
    within '.form' do
      click_on 'Sign Up'
    end
    expect(current_path).to eq(new_project_path)
  end

end
