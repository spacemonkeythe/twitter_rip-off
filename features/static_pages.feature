Feature: User can see home and help page
  As a site user I can visit home and help page

  Scenario: User can view home page
    Given I am on the application's home page
    Then I can see home page content

  Scenario: User can view help page
    Given I am on the application's help page
    Then I can see help page content

  Scenario: User can view About Us page
    Given I am on the application's about page
    Then I can see about page content
