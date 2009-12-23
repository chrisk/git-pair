require 'tmpdir'
require 'test/unit/assertions'
World(Test::Unit::Assertions)


module RepositoryHelper
  # TODO: use 1.8.7's Dir.mktmpdir?
  TEST_REPO_PATH         = File.join(Dir::tmpdir, "git-pair-test-repo")
  TEST_REPO_DOT_GIT_PATH = "#{TEST_REPO_PATH}/.git"

  PROJECT_PATH       = File.join(File.dirname(__FILE__), "../..")
  GIT_PAIR           = "#{PROJECT_PATH}/bin/git-pair"
  CONFIG_BACKUP_PATH = "#{PROJECT_PATH}/tmp"

  def git_pair(options = "")
    output = `GIT_DIR=#{TEST_REPO_DOT_GIT_PATH} && #{GIT_PAIR} #{options} 2>&1`
    output.gsub(/\e\[\d\d?m/, '')  # strip any ANSI colors
  end

  def git_config
    `GIT_DIR=#{TEST_REPO_DOT_GIT_PATH} && git config --list 2>&1`
  end

  def backup_gitconfigs
    FileUtils.mkdir_p CONFIG_BACKUP_PATH
    FileUtils.cp File.expand_path("~/.gitconfig"), "#{CONFIG_BACKUP_PATH}/.gitconfig.backup"
    FileUtils.cp "#{PROJECT_PATH}/.git/config", "#{CONFIG_BACKUP_PATH}/config.backup"
  end

  def restore_gitconfigs
    FileUtils.cp "#{CONFIG_BACKUP_PATH}/config.backup",     "#{PROJECT_PATH}/.git/config"
    FileUtils.cp "#{CONFIG_BACKUP_PATH}/.gitconfig.backup", File.expand_path("~/.gitconfig")
    FileUtils.rm_rf CONFIG_BACKUP_PATH
  end
end

World(RepositoryHelper)


Before do
  backup_gitconfigs
  FileUtils.mkdir_p RepositoryHelper::TEST_REPO_PATH
  `GIT_DIR=#{RepositoryHelper::TEST_REPO_DOT_GIT_PATH} && git init`
end

After do
  FileUtils.rm_rf RepositoryHelper::TEST_REPO_PATH
  restore_gitconfigs
end
