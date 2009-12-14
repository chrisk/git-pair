C_BOLD, C_REVERSE, C_RED, C_RESET = "\e[1m", "\e[7m", "\e[91m", "\e[0m"

module GitPair

  VERSION = File.read(File.join(File.dirname(__FILE__), "git-pair", "VERSION")).strip

  C_BOLD, C_REVERSE, C_RED, C_RESET = "\e[1m", "\e[7m", "\e[91m", "\e[0m"


  class NoMatchingAuthorsError < ArgumentError; end
  class MissingConfigurationError < RuntimeError; end


  module Commands
    def add(author_string)
      @config_changed = true
      authors = Helpers.author_strings_with_new(author_string)
      remove_all
      authors.each do |name_and_email|
        `git config --add git-pair.authors "#{name_and_email}"`
      end
    end

    def remove(name)
      @config_changed = true
      `git config --unset-all git-pair.authors "^#{name} <"`
    end

    def remove_all
      @config_changed = true
      `git config --unset-all git-pair.authors`
    end

    def config_change_made?
      @config_changed
    end

    def switch(abbreviations)
      raise MissingConfigurationError, "Please add some authors first" if Helpers.author_names.empty?

      names = abbreviations.map { |abbrev|
        name = Helpers.author_name_from_abbreviation(abbrev)
        raise NoMatchingAuthorsError, "no authors matched #{abbrev}" if name.nil?
        name
      }

      sorted_names = names.uniq.sort_by { |name| name.split.last }
      `git config user.name "#{sorted_names.join(' + ')}"`

      # TODO: prompt for email if not already known
    end

    extend self
  end


  module Helpers
    def display_string_for_config
      "#{C_BOLD}     Author list: #{C_RESET}" + author_names.join("\n                  ")
    end

    def display_string_for_current_info
      "#{C_BOLD}  Current author: #{C_RESET}" + current_author + "\n" +
      "#{C_BOLD}   Current email: #{C_RESET}" + current_email + "\n "
    end

    def author_strings
      `git config --get-all git-pair.authors`.split("\n")
    end

    def author_strings_with_new(author_string)
      strings = author_strings.push(author_string)

      strings.reject! { |str|
        !strings.one? { |s| parse_author_string(s).first == parse_author_string(str).first }
      }
      strings.push(author_string) if !strings.include?(author_string)
      strings.sort_by { |str| parse_author_string(str).first }
    end

    def author_names
      author_strings.map { |line| parse_author_string(line).first }.sort_by { |name| name.split.last }
    end

    def email(*initials_list)
      initials_string = initials_list.map { |initials| "+#{initials}" }.join
      'dev@example.com'.sub("@", "#{initials_string}@")
    end

    def current_author
      `git config --get user.name`.strip
    end

    def current_email
      `git config --get user.email`.strip
    end

    def author_name_from_abbreviation(abbrev)
      # initials
      author_names.each do |name|
        return name if abbrev.downcase == name.split.map { |word| word[0].chr }.join.downcase
      end

      # start of a name
      author_names.each do |name|
        return name if name.gsub(" ", "") =~ /^#{abbrev}/i
      end

      # includes the letters in order
      author_names.detect do |name|
        name =~ /#{abbrev.split("").join(".*")}/i
      end
    end

    def parse_author_string(author_string)
      author_string =~ /^(.+)\s+<([^>]+)>$/
      [$1, $2]
    end

    def abort(error_message, extra = "")
      super "#{C_RED}#{C_REVERSE} Error: #{error_message} #{C_RESET}\n" + extra
    end

    extend self
  end
end
