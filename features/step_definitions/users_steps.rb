Given(/^I am signed up and signed in user$/) do
  @user = FactoryGirl.create(:user)
end

When(/^I visit my profile page$/) do
  visit user_path(@user)
end

Then(/^I shud be able to see its content$/) do
  page.find("h1", text: @user.name)
end
