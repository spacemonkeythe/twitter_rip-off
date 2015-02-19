Given(/^I am admin$/) do
  @user = FactoryGirl.create(:user, :admin)
end

Given(/^there is at least one signed up user$/) do
  @user_1 = FactoryGirl.create(:user)
end

Given(/^I am on the user's edit profile page$/) do
  visit admin_users_path
  find_link(@user_1.name).click
  expect(page).to have_content(@user_1.name)
  find_link("Edit").click
end

Then(/^user's name should be updated$/) do
  expect(page).to have_content("My new name")
end

Then(/^user's email should be updated$/) do
  visit edit_admin_user_path(@user_1)
  page.find("label", :text => "Email").text("mynewemail@gmail.com")
end

When(/^I try to delete user's account$/) do
  find_link("Delete").click
  page.driver.browser.switch_to.alert.accept
end
