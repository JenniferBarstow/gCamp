class Membership < ActiveRecord::Base
  ROLE = ["Member", "Owner"]
  validates :user, presence: true
  belongs_to :user
  belongs_to :project

end
