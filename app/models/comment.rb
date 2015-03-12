class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :description, presence: true
end
