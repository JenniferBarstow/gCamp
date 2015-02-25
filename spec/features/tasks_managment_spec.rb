require "rails_helper"

describe "the user interacting with: task crud" do
  it "is complete" do
    visit tasks_path
    expect(page).to have_content "Tasks"

    click_on "New Task"

    fill_in "Description", with: "hike"
    fill_in "Due date", with: "02/03/2015"

    click_on "Create Task"

    expect(page).to have_content "hike"
    expect(page).to have_content "03/02/2015"

    click_on "Edit"

    fill_in "Description", with: "hike!"
    fill_in "Due date", with: "04/05/2015"
    check "Complete"
    click_on "Update Task"

    expect(page).to have_content "hike!"
    expect(page).to have_content "05/04/2015"

    visit tasks_path

    click_on "Delete"

    expect(page).to_not have_content "hike!"
    expect(page).to_not have_content "05/04/2015"

  end
end
