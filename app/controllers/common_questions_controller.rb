class CommonQuestionsController < ApplicationController
  skip_before_action :ensure_current_user
  def index
    @questions_array =

      [CommonQuestion.new('What is gCamp?','gCamp is an awesome tool that is going to change your life. gCamp is your one stop shop to organize all your tasks. You\'ll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world.','What-is-gCamp?'),
       CommonQuestion.new('How do I join gCamp?','As soon as it\'s ready for the public, you\'ll see a sign up link in the upper right. Once that\'s there, just click it and fill in the form!', 'How-do-I-join-gCamp?'),
       CommonQuestion.new('When will gCamp be finished?','gCamp is a work in progress. That being said, it should be fully functional in the next few weeks. Functional. Check in daily for new features and awesome functionality. It\'s going to blow your mind. Organization is just a click away. Amazing!', 'When-will-gCamp-be-finished?')
      ]
  end
end
