Given(/^I am on the application's home page$/) do
  visit home_path
end

Then(/^I can see home page content$/) do
  find_link("Twitter")
end

Given(/^I am on the application's help page$/) do
  visit help_path
end

Then(/^I can see help page content$/) do
  page.find("h1", :text => "Help")
end

Given(/^I am on the application's about page$/) do
  visit about_path
end

Then(/^I can see about page content$/) do
  page.find("h1", :text => "About Us")
end

