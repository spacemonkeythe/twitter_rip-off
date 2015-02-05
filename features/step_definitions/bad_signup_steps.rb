Given(/^I am on the signup page$/) do
  visit new_user_path
end

Given(/^I fill out a "(.*?)" field with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I submit given data$/) do
  click_button "Create my account"
end

Then(/^I should see warning message for "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Given(/^i fill out a name field with name which is too long$/) do
  fill_in "Name", with: "a"*51
end

Given(/^I fill out email field with invalid formated email$/) do
  fill_in "Email", with: "a@b"
end

Given(/^And I fill out password field with password too short$/) do
  fill_in "Password", with: "1234567"
end
