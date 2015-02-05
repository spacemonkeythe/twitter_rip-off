Feature: Good and bad login and logout
  As a registrated user I can login and logout from the site.


  Background:


  @javascript
  Scenario: I try to login without email and password
    Given I am on the application's home page
    And I am registrated user
    And I am not loged in
    When I try to log in without email and password
    Then I should see warning message for "Invalid email/password combination"

  @javascript
  Scenario: I try to login without a password
    Given I am on the application's home page
    And I am registrated user
    And I am not loged in
    When I try to log in without password
    Then I should see warning message for "Invalid email/password combination"

  @javascript
  Scenario: I try to login without an email
    Given I am on the application's home page
    And I am registrated user
    And I am not loged in
    When I try to log in without email
    Then I should see warning message for "Invalid email/password combination"

  @javascript
  Scenario: I try to login with wrong email
    Given I am on the application's home page
    And I am registrated user
    And I am not loged in
    When I try to log in with wrong email
    Then I should see warning message for "Invalid email/password combination"

  @javascript
  Scenario: I try to login with wrong password
    Given I am on the application's home page
    And I am registrated user
    And I am not loged in
    When I try to log in with wrong password
    Then I should see warning message for "Invalid email/password combination"

  @javascript
  Scenario: I cancel loging in
    Given I am on the application's home page
    And I am registrated user
    And I am not loged in
    When I cancel loging in
    Then I should be on the home page
