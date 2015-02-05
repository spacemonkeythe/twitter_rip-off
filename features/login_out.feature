Feature: Good and bad login and logout
  As a registrated user I can login and logout from the site.

  Background:
    Given I am registrated user

  Scenario: I try to login without email and password
    When I try to log in without email and password
    Then I should see warning message for "Invalid email/password combination"

  Scenario: I try to login without a password
    When I try to log in without password
    Then I should see warning message for "Invalid email/password combination"

  Scenario: I try to login without an email
    When I try to log in without email
    Then I should see warning message for "Invalid email/password combination"

  Scenario: I try to login with wrong email
    When I try to log in with wrong email
    Then I should see warning message for "Invalid email/password combination"

  Scenario: I try to login with wrong password
    When I try to log in with wrong password
    Then I should see warning message for "Invalid email/password combination"

  Scenario: I cancel loging in
    When I cancel loging in
    Then I should be on the home page

  Scenario: Valid login
    When I provide valid credentials
    Then I should be loged in

  Scenario: When I sign up I should bee signed in
    Given I am on the signup page
    And I fill out a "Name" field with "test name"
    And I fill out a "Email" field with "test@test.com"
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test123456"
    When I submit given data
    Then I should be loged in

  @javascript
  Scenario: Log out
    When I provide valid credentials
    And I logout
    Then I should be loged out
