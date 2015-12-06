Feature: User can view existing movie

Background: movies in database
       
  Given the following movies exist:
    | title        | rating | director     | release_date |
    | Star Wars    | PG     | George Lucas |   1977-05-25 |
    | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
    | Alien        | R      |              |   1979-05-25 |
    | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: Viewing a movie
  Given I am on the RottenPotatoes home page
  When I follow "More about Alien"
  Then I should be on the details page for "Alien"
