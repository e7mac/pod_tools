module PodTools::PodfileReader 
  def read_podfile(filename, local_pods, branch, &block)
    new_lines = ""
    IO.readlines(filename).each do |line|
      match_data = /pod '(?<podname>\w+)'/.match(line)
      if match_data
        podname = match_data['podname']
        if local_pods.index(podname) 
          # Keep this as a local pod
          new_line = "pod '#{podname}', :path=> \"../#{podname}/#{podname}.podspec\" \n"
          yield(podname, :clone)
        elsif podname[0..1] == "TP"
          # one of our pods, use the required branch
          new_line = "pod '#{podname}', :git => '#{ENV['GIT_REPO_BASE_URL']}/#{podname}.git', :branch => #{branch} \n"
          yield(podname, :none)
        else
          new_line = line
        end
      else
        new_line = line
      end
      new_lines = new_lines + new_line
    end
    new_lines
  end
end