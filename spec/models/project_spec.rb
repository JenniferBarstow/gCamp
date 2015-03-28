require "rails_helper"

describe Project do
  describe "#is_admin_owner?" do
    it "returns true if the user is a owner of the project" do
      project = create_project
      user = create_user
      create_membership(project_id: project.id, user_id: user.id, role: "Owner")

      expect(project.is_admin_owner?(user)).to eq true
    end

    it "returns false if the user is a member of the project" do
      project = create_project
      user = create_user(first_name: "Hank the tank")
      create_membership(project_id: project.id, user_id: user.id, role: "Member")

      expect(project.is_admin_owner?(user)).to eq false
    end

    it "returns false if the user is not associated to the project" do
      project = create_project
      user = create_user(first_name: "Hank the tank")

      expect(project.is_admin_owner?(user)).to eq false
    end
  end

  describe "#has_membership?" do
    it "returns true if the user is a owner of the project" do
      project = create_project
      user = create_user
      create_membership(project_id: project.id, user_id: user.id, role: "Owner")

      expect(project.has_membership?(user)).to eq true
    end

    it "returns false if the user is a member of the project" do
      project = create_project
      user = create_user(first_name: "Hank the tank")
      create_membership(project_id: project.id, user_id: user.id, role: "Member")

      expect(project.has_membership?(user)).to eq true
    end

    it "returns false if the user is not associated to the project" do
      project = create_project
      user = create_user(first_name: "Hank the tank")

      expect(project.has_membership?(user)).to eq false
    end
  end
end
