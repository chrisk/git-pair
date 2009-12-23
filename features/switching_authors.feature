Feature: Switching authors
  In order to indicate which authors are committing
  A user should be able to
  change the currently active pair

  Scenario: Two authors with similar emails
    Given I have added the author "Linus Torvalds <linus@example.org>"
    And I have added the author "Junio C Hamano <junio@example.org>"
    When I switch to the pair "LT JH"
    Then `git pair` should display "Junio C Hamano + Linus Torvalds" for the current author
    And `git pair` should display "tbd+junio+linus@example.org" for the current email
