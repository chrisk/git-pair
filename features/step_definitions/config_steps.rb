When /^I add an author named "([^\"]*)"$/ do |name|
  git_pair '--add "Linus Torvalds"'
end

Then /^`git pair` should display "([^\"]*)" in its author list only once$/ do |name|
  output = git_pair
  output =~ /Author list: (.+)\n\s?\n/im
  authors = $1.strip.split("\n").map { |author| author.strip }

  assert_equal 1, authors.select { |author| author == name}.size
end
