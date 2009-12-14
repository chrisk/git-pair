# git-pair

A git porcelain for changing `user.name` and `user.email` so you can commit as
more than one author.

## Usage

Install the gem:

    gem install git-pair

And here's how to use it! (Note: this reflects the current development
version. Run `git pair` with no arguments to see the instructions for your
version.)

    $ git pair

    Configuration:
      git pair [options]
        -a, --add NAME                   Add an author. Format: "Author Name <author@example.com>"
        -r, --remove NAME                Remove an author. Use the full name.

    Switching authors:
      git pair AA [BB]                   Where AA and BB are any abbreviation of an
                                         author's name. You can specify one or more authors.

Once you've added authors, running `git pair` with no options will also print
out their names, the current pair, and some other information.

## Known issues

* I just shoved everything into a gem. Refactor into separate files.
* Test coverage is low -- I'm working on a cucumber suite.

## Feature hit list

* <s>It'd be better if you could specify an email address for each author instead
  of just automatically using the authors' initials. Especially if you have two
  authors with the same initials. And also because when there's just one author,
  it should use that person's email instead of an interpolation like
  `devs+ck@example.com`.</s> Started! Now accepts author names w/ emails, but
  doesn't yet prompt for/generate an email based on the pairs' addresses.
* Needs `git pair --reset` to restore the original `user.name` and `user.email`.
  For now, just `git config --edit` and remove the `[user]` section to go back
  to your global config.

## License

Copyright (c) 2009 Chris Kampmeier. See `LICENSE` for details.
