Feature: Adding an author
  In order remove old pairing partners
  A user should be able to
  remove a name from the list of authors

  Scenario: removing a name
    When I add the author "Linus Torvalds <linus@example.org>"
    And I add the author "Junio C Hamano <junio@example.org>"
    And I remove the name "Junio C Hamano"
    Then `git pair` should display the following author list:
      | name           |
      | Linus Torvalds |

  Scenario: removing all names
    When I add the author "Linus Torvalds <linus@example.org>"
    And I add the author "Junio C Hamano <junio@example.org>"
    And I remove the name "Linus Torvalds"
    And I remove the name "Junio C Hamano"
    Then `git pair` should display an empty author list
