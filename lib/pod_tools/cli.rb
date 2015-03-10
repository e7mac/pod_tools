require 'thor'
require 'cocoapods'
require 'fileutils'

class PodTools::CLI < Thor
  include PodTools::PodfileReader

  method_option :keep, :type => :array, :default => [], 
                :banner => "names of pods to use as local copy from your machine."
  method_option :branch, :default => "development",
                :banner => "branch to switch to before running pod install"
  desc "install", "Install pods from alternative pod paths."
  def install 
    say "Copying the original Podfile"
    FileUtils.cp('Podfile', 'Podfile.original')

    local_pods = options[:keep]
    branch = options[:branch]
    new_lines = read_podfile('Podfile.original', local_pods, branch) do |podname, action| 
      if (action == :clone) 
        clone_command = "git clone #{ENV['GIT_REPO_BASE_URL']}/#{podname}.git ../#{podname}"
        say "Cloning: #{clone_command}"
        system clone_command

        checkout_command = "pushd ../#{podname}; git checkout #{branch}; popd"
        say "Checking out: #{checkout_command}"
        system checkout_command
      end
    end
    say "\n"
    say "Pod installing the below modified Podfile: \n"
    say "===================================== \n"
    say "\n"
    say new_lines
    IO.write('Podfile', new_lines)

    args = ['install', '--no-repo-update']
    Pod::Command.run(args)

    say "Copying back the original Podfile."
    FileUtils.cp('Podfile.original', 'Podfile')
    FileUtils.rm('Podfile.original')
  end
  
  desc "update", "Update pods from alternative pod paths."
  def update 
    begin
      say "Copying the original Podfile"
      FileUtils.cp('Podfile', 'Podfile.original')

      local_pods = options[:keep]
      branch = options[:branch]
      new_lines = read_podfile('Podfile.original', local_pods, branch) do |podname, action| 
        if (action == :clone) 
          clone_command = "git clone #{ENV['GIT_REPO_BASE_URL']}/#{podname}.git ../#{podname}"
          say "Cloning: #{clone_command}"
          system clone_command

          checkout_command = "pushd ../#{podname}; git checkout #{branch}; popd"
          say "Checking out: #{checkout_command}"
          system checkout_command
        end
      end
      say "\n"
      say "Pod installing the below modified Podfile: \n"
      say "===================================== \n"
      say "\n"
      say new_lines
      IO.write('Podfile', new_lines)

      args = ['update']
      Pod::Command.run(args)

      say "Copying back the original Podfile."
      FileUtils.cp('Podfile.original', 'Podfile')
      FileUtils.rm('Podfile.original')
    rescue Interrupt
      say "Copying back the original Podfile."
      FileUtils.cp('Podfile.original', 'Podfile')
      FileUtils.rm('Podfile.original')
    rescue Exception => e
      say "Copying back the original Podfile."
      FileUtils.cp('Podfile.original', 'Podfile')
      FileUtils.rm('Podfile.original')
    end
  end
end