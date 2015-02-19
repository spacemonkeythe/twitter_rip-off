Feature: Invalid profile edit
  As a loged in user I must provide valid credentials for editing my profile

  Background: 
    Given I am registrated user
    And I am signed in user
    And I am on the edit profile page

  @javascript
  Scenario: User is left out username
    Given I fill out a "Email" field with "test@test.com"
    And I fill out a "Name" field with ""
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test123456"
    When I try to update data
    Then I should see warning message for "Name can't be blank"

  @javascript
  Scenario: User is left out email adress
    Given I fill out a "Email" field with ""
    And I fill out a "Name" field with "My new name"
    And I fill out a "Password" field with "test123456"
    And I fill out a "user_password_confirmation" field with "test123456"
    When I try to update data
    Then I should see warning message for "Email can't be blank"

