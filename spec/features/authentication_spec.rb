require 'rails_helper'

feature 'should be able to sign in' do

  before do
    @user = create_user
  end

  scenario 'should be able to click sign in then sign in' do
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    within '.form' do
      click_on 'Sign In'
    end
    within '.alert-success' do
      expect(page).to have_content 'You have successfully signed in'
    end
  end

  scenario 'should see an error if signing in with bad information' do
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: 'invalid@nope.com'
    fill_in 'Password', with: 'invalid'
    within '.form' do
      click_on 'Sign In'
    end
    expect(page).to have_content 'Email / Password combination is invalid'
  end

  scenario 'should be redirected to root page after sign in' do
    visit faq_path
    click_on 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    within '.form' do
      click_on 'Sign In'
    end
    expect(current_path).to eq(root_path)
  end

end
