require "rails_helper"

  describe UsersController do
    describe "GET #index" do
      it 'renders the index view' do
        user = create_user
        session[:user_id] = user.id

        get :index
        expect(response).to render_template(:index)
        expect(assigns(:users)).to eq [user]
      end

      describe "Permissions" do
        it 'redirects a non-logged in user' do
          get :index
          expect(response).to redirect_to sign_in_path
          expect(flash[:warning]).to eq "You must sign in"
        end

        it 'renders 404 if user tries to edit another user' do
        user = create_user
        session[:user_id] = user.id

        user2 = create_user(  first_name: 'Colin',
          last_name: 'Cat',
          email: "colin@gmail.com",
          password: 'password',
          password_confirmation: 'password')
        session[:user_id] = user2.id

        get :edit, id:user.id
        expect(response).to render_template file: '404.html'
      end
    end
  end




  end
