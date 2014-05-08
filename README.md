# PodTools

Tools for using your own cocoapods in your projects. When you are building an iOS app, 
it is beneficial to divide the app into separate reusable pods. We build these simple commandline tools to simplify the management of these pods.

## Installation

Add this line to your application's Gemfile:

    gem 'pod_tools',  :git => 'git://github.com/keremk/pod_tools.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install specific_install
    $ gem specific_install -l https://github.com/keremk/pod_tools.git

## Preparation

Below commands assumes that you have the following setup:

* GIT_REPO_BASE_URL environment variable pointing to your github repository for your private pods. And the Github project names follow the convention of Podname1, Podname2... To set the environment variable, in your shell's setup file (such as ~/.zshrc) set the following environment variable:

    export GIT_REPO_BASE_URL=url/to/your/github/repo

* Cocoapods private repo setup. Your organization should setup a private repo as instructed [here](http://guides.cocoapods.org/making/private-cocoapods.html). The pod_submit command will read your local repo from ~/.cocoapods folder. It also assumes there is only one private repo there.


## Usage

### pod_install

This is a tool that runs pod install on a modified Podfile. This way you can keep some of the pods (ones you are actively developing) on your local machine and some will come from your local private pod repository. This helps when you are rapidly iterating on those pods.

    pod_install --keep Podname1 Podname2

will assume there is a Podfile from where you run the above command, copy the original Podfile to a temp file, modify the Podfile as such:

    pod 'Podname1', :path => "../Podname1/Podname1.podspec"
    pod 'Podname2', :path => "../Podname2/Podname2.podspec"

It will try to clone those pods in the folder as shown above using the ENV variable set for GIT_REPO_BASE_URL. And then it will run pod install on that modified Podfile. After that, it will revert back to the original Podfile, so that you don't need worry about your Podfile changing in the git repository, while you are working on it.

### pod_submit

This is a tool that pops up your default editor (as specified in the $EDITOR variable of your commandline shell) to edit the version of your podspec. Then:
* commits the podspec to the git repo, 
* tags your git repo with the same version as what you had in the podspec file,
* pushes the changes with tags to your git origin,
* pushes the podspec to your local private cocoapods repository.  

You need to run this from the root of your pod project where the podspec file is located:

    pod_submit

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
