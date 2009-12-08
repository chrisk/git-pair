Feature: Adding an author
  In order to commit as a pair
  A user should be able to
  add a name to the list of authors

  Scenario: adding a name
    When I add an author named "Linus Torvalds"
    Then `git pair` should display "Linus Torvalds" in its author list

  Scenario: adding the same name twice
    When I add an author named "Linus Torvalds"
    And I add an author named "Linus Torvalds"
    Then `git pair` should display "Linus Torvalds" in its author list only once
    And the gitconfig should include "Linus Torvalds" in its author list only once
