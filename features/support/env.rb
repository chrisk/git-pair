require 'test/unit/assertions'
World(Test::Unit::Assertions)


module TestHelper
  TMP_PATH  = File.expand_path(File.join(File.dirname(__FILE__), "../../tmp"))
  REPO_PATH = File.join(TMP_PATH, "repo")
  GIT_PAIR  = File.expand_path(File.join(File.dirname(__FILE__), "../../bin/git-pair"))

  def git_pair(options = "")
    output = ""
    FileUtils.cd(REPO_PATH) do
      output = `#{GIT_PAIR} #{options} 2>&1`
    end
    output.gsub(/\e\[\d\d?m/, '')  # strip any ANSI colors
  end
end

World(TestHelper)


Before do
  FileUtils.mkdir_p TestHelper::REPO_PATH
  FileUtils.cd(TestHelper::REPO_PATH) { `git init` }
end

After do
  FileUtils.rm_rf TestHelper::TMP_PATH
end
