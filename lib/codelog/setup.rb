require 'fileutils'

class CodeLog::Setup

  def self.scan(path, depth=1)

    # verify that the settings folder and file exist
    verify_settings_folder

    Dir.chdir(path)

    directories = Dir.glob('*').select { |f| File.directory? f }

    directories.each do |dir|
      print "checking : #{path}#{dir} "
      Dir.chdir("#{path}#{dir}")

      require 'open3'
      stdin, stdout, stderr, wait_thr = Open3.popen3('git', 'rev-parse')
      stdout.gets(nil)
      stdout.close
      stderr.gets(nil)
      stderr.close
      exit_code = wait_thr.value

      print((exit_code == 0 ? ' ... YES' : ' ... NO') + "\n\n")

      commits = []
      if exit_code == 0
        begin
          commits << history("#{path}#{dir}")
        rescue Git::GitExecuteError
          # result = 'Something went wrong with this repo ... '
        end
      end



      commits.each do |commit_ref|
        g = Git.open("#{path}#{dir}")
        commit = g.gcommit(commit_ref)

        print commit.author.name
        print commit.author.email
        print commit.author.date.strftime("%m-%d-%y")
        print commit.committer.name
        print commit.date.strftime("%m-%d-%y")
      end
      # print result

    end
  end

  def self.history(path)
    g = Git.open(path)
    print g.log.since("\n\n")
    print g.log.since('1 months ago')
    print g.log.since("\n\n")
  end

  private

  def self.verify_settings_folder
    # check folder not exist
    pwd = Dir.pwd
    print "Verifying file system setup.\n"
    print "---------------------------------------------------\n\n"
    print "checking directory : '#{ENV['HOME']+'/.codelog'}' exists.\n"


    unless Dir.exists?(ENV['HOME']+'/.codelog')
      print "Creating directory : '#{ENV['HOME']+'/.codelog'}'.\n"
      Dir.mkdir(ENV['HOME']+'/.codelog')
    end
    print "\n"

    Dir.chdir(ENV['HOME']+'/.codelog')

    print "checking file : '#{ENV['HOME']+'/.codelog/repositories.yml'}' exists.\n"
    unless Dir.exists?(ENV['HOME']+'/.codelog/repositories.yml')
      print "Creating file : '#{ENV['HOME']+'/.codelog'}'.\n"
      FileUtils.touch('repositories.yml')
    end

    print "OK, done! Good to go\n\n"
    Dir.chdir pwd
  end

end