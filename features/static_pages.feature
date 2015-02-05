Feature: User can see home and help page
  As a site user I can visit home and help page

  Background:
    Given I am on the application's home page

  Scenario: User can view home page
    Then I can see home page content

  Scenario: User can view help page
    When I visit application's help page
    Then I can see help page content

  Scenario: User can view About Us page
    When I visit application's About page
    Then I can see About page content

  Scenario: User can view Contacat page
    When I visit application's contact page
    Then I can see contact page content

  Scenario: User can visit Signup page
    When I visit Signup page
    Then I can see signup content
