# git-pair

A git porcelain for changing `user.name` and `user.email` so you can commit as
more than one author.

## Usage

Install the gem:

    gem install git-pair

And here's how to use it!

    $ git pair

    Configuration:
      git pair [options]
        -a, --add NAME                   Add an author. Use the full name.
        -r, --remove NAME                Remove an author. Use the full name.
        -e, --set-email TEMPLATE         Set the email template. A value like devs@example.com
                                         will be interpolated with the current authors' initials
                                         into something like devs+aa+bb@example.com.
        -x, --reset                      Reset to name and email in global config.

    Switching authors:
      git pair AA [BB]                   Where AA and BB are any abbreviation of an
                                         author's name. You can specify one or more authors.

Once you've added authors, running `git pair` with no options will also print
out their names, the current pair, and some other information.

## Known issues

* I just shoved everything into a gem. Refactor into separate files.
* Needs `git pair --reset` to restore the original `user.name` and `user.email`.
  For now, just `git config --edit` and remove the `[user]` section to go back
  to your global config.
* It'd be better if you could specify an email address for each author instead
  of just automatically using the authors' initials. Especially if you have two
  authors with the same initials. And also because when there's just one author,
  it should use that person's email instead of an interpolation like
  `devs+ck@example.com`.
* Don't add duplicate authors to the git-config (doesn't affect the proper
  functioning of git-pair, but makes `git pair --add` not idempotent and
  clutters up your config file).

## License

Copyright (c) 2009 Chris Kampmeier. See `LICENSE` for details.
