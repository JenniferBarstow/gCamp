def sign_in_user
 user = User.new(first_name: "John", last_name: "Smith", email: 'cheese_lover@cheese.example.com', password: 'cheese,duh!')
 user.save!
 visit root_path
 click_link 'Sign In'
 fill_in :email, with: 'cheese_lover@cheese.example.com'
 fill_in :password, with: 'cheese,duh!'
 click_button 'Sign In'
end
