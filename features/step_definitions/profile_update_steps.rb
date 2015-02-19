Then(/^I my password should be updated$/) do
  find_link("Account").click
  find_link("Log out").click
  visit login_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: "new123456"
  click_button "Sign in"
  page.find("h1", text: @user.name)
end

When(/^I try to delete my account$/) do
  find_link("delete").click
  page.driver.browser.switch_to.alert.accept
end

Then(/^account should be deleted$/) do
expect(page).to have_content("A user has been removed.")
end

