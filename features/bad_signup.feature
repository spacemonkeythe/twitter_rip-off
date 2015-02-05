Feature: Invalid sign up
  As a site visitor I must provide valid credentials for sign up

  Background: 
    Given I am on the signup page

  Scenario: User is left out username
    Given I fill out a "Email" field with "test@test.com"
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test123456"
    When I submit given data
    Then I should see warning message for "Name can't be blank"

  Scenario: User provides too long name
    Given i fill out a name field with name which is too long
    And I fill out a "Email" field with "test@test.com"
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test123456"
    When I submit given data
    Then I should see warning message for "Name is too long (maximum is 50 characters)"

  Scenario: User is left out a email
    Given I fill out a "Name" field with "test name"
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test123456"
    When I submit given data
    Then I should see warning message for "Email can't be blank"

  Scenario: User provides a invalid formated email
    Given I fill out a "Name" field with "test name"
    And I fill out email field with invalid formated email
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test123456"
    When I submit given data
    Then I should see warning message for "Email is invalid"

  Scenario: User provides password which is too short
    Given I fill out a "Name" field with "test name"
    And I fill out a "Email" field with "test@test.com"
    And And I fill out password field with password too short
    And I fill out a "user_password_confirmation" field with "test123456"
    When I submit given data
    Then I should see warning message for "Password is too short (minimum is 8 characters)"

  Scenario: User is left out a password
    Given I fill out a "Name" field with "test name"
    And I fill out a "Email" field with "test@test.com"
    When I submit given data
    Then I should see warning message for "Password can't be blank"

  Scenario: User is left out a password confirmation
    Given I fill out a "Name" field with "test name"
    And I fill out a "Email" field with "test@test.com"
    And I fill out a "Password" field with "test123456"
    When I submit given data
    Then I should see warning message for "Password confirmation can't be blank"

  Scenario: Password and password confiramtion don't match
    Given I fill out a "Name" field with "test name"
    And I fill out a "Email" field with "test@test.com"
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test1234567"
    When I submit given data
    Then I should see warning message for "Password confirmation doesn't match Password"

