require "spec_helper"


feature "test" do
  deploy app.to_yaml

  describe "is local" do
    scenario "go", js: true do
      visit "/home/index"
      page.should have_content "Hello world"
      using_session :other do
        visit "/home/index"
        fill_in "Message", with: "You are awesome!"
        click_button "Push it"
      end
      page.should have_content "You are awesome!"
    end
  end
end
