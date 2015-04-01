require "rails_helper"

  describe MembershipsController do

    before :each do
      @user = create_user
      @project = create_project
      @membership = create_membership
      session[:user_id] = @user.id
    end


    describe 'Permissions' do
      it 'redirects non_owner or non-admin from membership index to projects path' do
        session.clear
        user1 = create_user
        session[:user_id] = user1.id

        patch :update, project_id: @project.id,

        id: @membership.id

        expect(response).to redirect_to projects_path
        expect(flash[:warning]).to eq "You do not have access to that project"
      end

      it 'has at least one user with the role of owner' do

        user1 = create_user( first_name: 'Steve',
          last_name: 'The Coolest',
          email: "steve@thecoolest.com",
          password: 'password',
          password_confirmation: 'password',
          admin: true)

        user2 = create_user( first_name: 'Dylan',
          last_name: 'The Great',
          email: "dylan@thegreat.com",
          password: 'password',
          password_confirmation: 'password',
          admin: false)

        project3 = create_project( name: 'Study Bam')
        membership1 = create_membership(project_id: project3.id,user_id: user1.id, role: 'Member')
        membership2 = create_membership(project_id: project3.id,user_id: user2.id, role: 'Owner')

        session[:user_id] = user1.id

        expect {
          delete :destroy, project_id: project3.id, id: membership2.id, membership: {role: 'Owner'}
        }.to_not change{Membership.all.count}

        expect(flash[:warning]).to eq "Projects must have at least one owner"
        expect(response).to redirect_to project_memberships_path
      end

      it 'ensures admin' do
        User.destroy_all

        user1 = create_user( first_name: 'Steve',
          last_name: 'The Coolest',
          email: "steve@thecoolest.com",
          password: 'password',
          password_confirmation: 'password',
          admin: false)

        user2 = create_user( first_name: 'Dylan',
          last_name: 'The Great',
          email: "dylan@thegreat.com",
          password: 'password',
          password_confirmation: 'password',
          admin: true)

        project3 = create_project(name: 'Study Bam')
        membership1 = create_membership(project_id: project3.id,user_id: user1.id, role: 'Member')
        membership2 = create_membership(project_id: project3.id,user_id: user2.id, role: 'Owner')
        session[:user_id] = user2.id

        expect {
          delete :destroy, project_id: project3.id, id: membership1.id
        }.to change{Membership.all.count}.by(-1)

        expect(flash[:notice]).to eq "Steve The Coolest was successfully removed"
        expect(response).to redirect_to project_memberships_path(project3)
      end
    end
  end
