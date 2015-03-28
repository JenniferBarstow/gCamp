class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments, dependent: :nullify

  def admin_or_owner?(project)
    self.memberships.find_by(project_id: project.id) != nil && self.memberships.find_by(project_id: project.id).role == 'Owner'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin_or_member(project)
    self.admin || self.memberships.find_by(project_id: project.id) != nil
  end


  def is_project_member?
    self.memberships.find_by(project_id: project.id) != nil
  end
end
