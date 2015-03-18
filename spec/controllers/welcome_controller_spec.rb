require "rails_helper"

describe WelcomeController do
  describe "GET #index" do
    it "should have an array of quotes" do

      get :index

      expect(assigns(:quotes_array)).to eq([
        {'quote' => '"gCamp has changed my life! It\'s the best tool I\'ve ever used."',
         'contributor' => 'Cayla Hayes'},
        {'quote' => '"Before gCamp I was a disorderly slob. Now I\'m more organized than I\'ve ever been."',
          'contributor' => 'Leta Jaskolski'},
        {'quote' => '"Don\'t hesitate - sign up right now! You\'ll never be the same"',
          'contributor' => 'Lavern Upton'}
      ])
    end
  end
end
