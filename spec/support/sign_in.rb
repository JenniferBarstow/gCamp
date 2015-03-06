def sign_in_user(user = create_user)
  visit sign_in_path
  click_link 'Sign In'
  fill_in :email, with: user.email
  fill_in :password, with: user.password
  click_button 'Sign In'
end
