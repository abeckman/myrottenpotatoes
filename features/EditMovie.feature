Feature: User can edit existing movie

Background: movies in database
       
  Given the following movies exist:
    | title        | rating | director     | release_date |
    | Star Wars    | PG     | George Lucas |   1977-05-25 |
    | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
    | Alien        | R      |              |   1979-05-25 |
    | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: Viewing a movie
  Given I am on the details page for "Alien"
  When I follow "Edit"
  Then I should be on the edit page for "Alien"
  When I select "PG" from "Rating"
  And I press "Update Movie Info"
  Then I should be on the details page for "Alien"
  And I should see "Rating: PG"
