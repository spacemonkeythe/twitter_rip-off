Given(/^I am registrated user$/) do
  @user = FactoryGirl.create(:user)
end

When(/^I try to log in without email and password$/) do
  visit login_path
  click_button "Sign in"
end

When(/^I try to log in without password$/) do
  visit login_path
  fill_in "Email", with: @user.email
  click_button "Sign in"
end

When(/^I try to log in without email$/) do
  visit login_path
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

When(/^I try to log in with wrong email$/) do
  visit login_path
  fill_in "Email", with: "example@exaple.com"
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

When(/^I try to log in with wrong password$/) do
  visit login_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: "1234548907890"
  click_button "Sign in"
end

When(/^I cancel loging in$/) do
  visit login_path
  click_link "Cancel"
end

Then(/^I should be on the home page$/) do
  expect(page).to have_content("Welcome to Twitter rip-off app")
end

When(/^I provide valid credentials$/) do
  visit login_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then(/^I should be loged in$/) do
  page.find("a", text: "Account")
end

When(/^I logout$/) do
  find_link("Account").click
  find_link("Log out").click
end

Then(/^I should be loged out$/) do
  find("a", text: "Log in")
end

