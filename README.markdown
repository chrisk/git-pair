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

    Switching authors:
      git pair AA [BB]                   Where AA and BB are any abbreviation of an
                                         author's name. You can specify one or more authors.

Once you've added authors, running `git pair` with no options will also print
out their names, the current pair, and some other information.

## License

Copyright (c) 2009 Chris Kampmeier. See `LICENSE` for details.
