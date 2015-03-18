require "rails_helper"

describe TermsController do
  describe "GET #index" do
    it 'renders the index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET about_page" do
    it 'renders the about_page view' do
      get :about_page
      expect(response).to render_template(:about_page)
    end

    it "should contain a list for project objects" do
      project = create_project

      get :about_page

      expect(assigns(:projects)).to eq [project]
    end


    it "should contain a list for user objects" do
      user = create_user

      get :about_page

      expect(assigns(:users)).to eq [user]
    end

    it "should contain a list for comment objects" do
      comment = create_comment

      get :about_page

      expect(assigns(:comments)).to eq [comment]
    end

    it "should contain a list for membership objects" do
      membership = create_membership

      get :about_page

      expect(assigns(:memberships)).to eq [membership]
    end

    it "should contain a list for task objects" do
      task = create_task

      get :about_page

      expect(assigns(:tasks)).to eq [task]
    end
  end
end
