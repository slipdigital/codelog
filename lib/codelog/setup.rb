require 'fileutils'
require 'yaml'

class CodeLog::Setup

  def self.scan(path, depth=1, period='1 week ago')

    # verify that the settings folder and file exist
    verify_settings_folder

    Dir.chdir(path)

    directories = Dir.glob('*').select { |f| File.directory? f }

    directories.each do |dir|

      Dir.chdir("#{path}#{dir}")

      require 'open3'
      stdin, stdout, stderr, wait_thr = Open3.popen3('git', 'rev-parse')
      stdout.gets(nil)
      stdout.close
      stderr.gets(nil)
      stderr.close
      exit_code = wait_thr.value

      if exit_code
        print "#{path}#{dir} is a valid repo : \n\n"
        store_repo_path("#{path}#{dir}")
      end

      commits = []
      if exit_code == 0
        begin
          commits.push(*history("#{path}#{dir}", period))
        rescue Git::GitExecuteError
          # result = 'Something went wrong with this repo ... '
        end
      end


      commits.each do |commit_obj|
        g = Git.open(commit_obj.instance_variable_get('@base').instance_variable_get('@working_directory').path)
        commit = g.gcommit(commit_obj.sha)

        print commit.committer.name + ' : '
        print commit.author.email + ' : '
        print commit.author.date.strftime("%m-%d-%y %H:%M:%S")
        print "\n\n"
        print commit.message
        print "\n\n"
        print commit.to_yaml
      end
      # print result

    end
  end

  def self.history(path, period)
    g = Git.open(path)
    g.log.since(period)
  end

  private

  def self.verify_settings_folder
    # check folder not exist
    pwd = Dir.pwd

    unless Dir.exists?(ENV['HOME']+'/.codelog') || !Dir.exists?(ENV['HOME']+'/.codelog/repositories.yml')
      print "Verifying file system setup.\n"
      print "---------------------------------------------------\n\n"
      print "checking directory : '#{ENV['HOME']+'/.codelog'}' exists.\n"
    end


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

  def self.store_repo_path(path)

  end

end