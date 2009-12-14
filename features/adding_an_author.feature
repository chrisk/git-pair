Feature: Adding an author
  In order to commit as a pair
  A user should be able to
  add a name and email to the list of authors

  Scenario: adding a name and email
    When I add the author "Linus Torvalds <linus@example.org>"
    Then `git pair` should display "Linus Torvalds" in its author list

  Scenario: adding the same name and email twice
    When I add the author "Linus Torvalds <linus@example.org>"
    And I add the author "Linus Torvalds <linus@example.org>"
    Then `git pair` should display "Linus Torvalds" in its author list only once
    And the gitconfig should include "Linus Torvalds" in its author list only once

  Scenario: adding the same name twice with different emails
    When I add the author "Linus Torvalds <linus@example.org>"
    And I add the author "Linus Torvalds <linus@example.com>"
    Then `git pair` should display "Linus Torvalds" in its author list only once
    And the gitconfig should include "Linus Torvalds" in its author list only once
    And the gitconfig should include "linus@example.com" as the email of "Linus Torvalds"
