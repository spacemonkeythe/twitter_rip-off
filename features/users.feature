Feature: User can browse through web site
  As a site visitor when I sign up then I should be able to visit other site pages

  Scenario: User can view his profile page
    Given I am signed up and signed in user
    When I visit my profile page
    Then I shud be able to see its content
