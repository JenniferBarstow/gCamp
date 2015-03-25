class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :tasks, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def owner?(user)
    membership = Membership.find_by(user_id: user.id, project_id: self.id)
    if membership == nil
      false
    else
      membership.role == "Owner"
    end
  end
end
