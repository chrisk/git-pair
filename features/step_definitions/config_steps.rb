When /^I add an author named "([^\"]*)"$/ do |name|
  git_pair '--add "Linus Torvalds"'
end

Then /^`git pair` should display "([^\"]*)" in its author list$/ do |name|
  output = git_pair
  authors = authors_list_from_output(output)
  assert authors.include?(name)
end

Then /^`git pair` should display "([^\"]*)" in its author list only once$/ do |name|
  output = git_pair
  authors = authors_list_from_output(output)
  assert_equal 1, authors.select { |author| author == name}.size
end

def authors_list_from_output(output)
  output =~ /Author list: (.+)\n\s?\n/im
  $1.strip.split("\n").map { |name| name.strip }
end
