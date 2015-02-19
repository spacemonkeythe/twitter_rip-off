Given(/^I am signed in user$/) do
  visit login_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Given(/^I am on the edit profile page$/) do
  visit root_path
  find_link("Account").click
  find_link("Settings").click
end

When(/^I try to update data$/) do
  click_button "Update my account"
end

