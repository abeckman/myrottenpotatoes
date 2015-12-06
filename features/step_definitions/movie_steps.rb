# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    new_movie = Movie.create!(movie)
# new_movie = Movie.create!(:title => movie["title"], :rating => movie["rating"], :release_date => movie["release_date"])
  end
# fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regexp = /#{e1}.*#{e2}/m # /m means match across newlines
#page.body.should =~ regexp
  expect(page.body).to match(regexp)
# fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck
    rating_list.split(', ').each {|rating|
      steps %Q{
        When I uncheck "ratings[#{rating}]"
      }
    }
  else
    rating_list.split(', ').each {|rating|
      steps %Q{
        When I check "ratings[#{rating}]"
      }
    }
  end

#  fail "Unimplemented"
end

Then /I should (not )?see the following ratings: (.*)/ do |shouldnot, rating_list|
  if shouldnot
    rating_list.split(', ').each {|rating|
      steps %Q{
        Then I should not see the movies rated "#{rating}"
      }
    }
  else
    rating_list.split(', ').each {|rating|
      steps %Q{
        Then I should see the movies rated "#{rating}"
      }
    }
  end
end

Then /I should (not )?see the movies rated (.*)/ do |shouldnot, rating|
  if shouldnot
    page.find('table#movies').has_no_text?("#{rating}")
  else
    @rating_count = Movie.where(:rating => "#{rating}" ).count
    @table_rating = page.all('table#movies', text: "#{rating}").count
    @rating_count == @table_rating
  end
end

Then /I should see all of the movies/ do
  # Make sure that all the movies in the app are visible in the table
  expect(page.all('table#movies tr').count).to eq(Movie.count + 1) # extra 1 for header
# fail "Unimplemented"
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |arg1, arg2|
# express the regexp above with the code you wish you had
  regexp = /#{arg1}.*#{arg2}/m # /m means match across newlines
  expect(page.body).to match(regexp)
end
