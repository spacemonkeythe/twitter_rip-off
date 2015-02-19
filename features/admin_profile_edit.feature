Feature: Valid profile editiing by admin
  As a admin user can edit all profiles

  Background: 
    Given I am admin
    And I am signed in user
    And there is at least one signed up user

  @javascript
  Scenario: Admin is left out user's name
    Given I am on the user's edit profile page
    And I fill out a "Email" field with "test@test.com"
    And I fill out a "Name" field with ""
    When I try to update data
    Then I should see warning message for "Name can't be blank"

  Scenario: Admin is left out user's email adress
    Given I am on the user's edit profile page
    And I fill out a "Email" field with ""
    And I fill out a "Name" field with "My new name"
    When I try to update data
    Then I should see warning message for "Email can't be blank"

  Scenario: Admin is able to update user's name
    Given I am on the user's edit profile page
    And I fill out a "Name" field with "My new name"
    When I try to update data
    Then user's name should be updated

  Scenario: Admin is able to update user's email address
    Given I am on the user's edit profile page
    And I fill out a "Email" field with "mynewemail@gmail.com"
    When I try to update data
    Then user's email should be updated

  @javascript
  Scenario: Admin is able to delete any account
    Given I am on the user's edit profile page
    When I try to delete user's account
    Then account should be deleted


