Feature: Valid sign up
  As a site visitor I provide valid credentials for sign up

  Scenario: I sign up with valid data
    Given I am on the signup page
    And I fill out a "Name" field with "test name"
    And I fill out a "Email" field with "test@test.com"
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test123456"
    When I submit given data
    Then I should see warning message for "Welcome to the Twitter rip-off app!"
