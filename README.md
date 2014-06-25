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

* GIT_REPO_BASE_URL: environment variable pointing to your github repository for your private pods. And the Github project names follow the convention of Podname1, Podname2... To set the environment variable, in your shell's setup file (such as ~/.zshrc) set the following environment variable:

    export GIT_REPO_BASE_URL=url/to/your/github/repo

* PRIVATE_POD_NAMESPACE: The usual 2-3 letter ObjectiveC namespacing convention for your pod names. This is used to pick your provide podfiles over the external ones you are using. This way the Podfile gets modified to use the specified branch of the repo for those pods.

## Usage

### pt install

This is a tool that runs pod install on a modified Podfile. This way you can keep some of the pods (ones you are actively developing) on your local machine and some will come from your local private pod repository. This helps when you are rapidly iterating on those pods.

    pt install --keep TPPodname1 TPPodname2 --branch Development

will assume there is a Podfile from where you run the above command, copy the original Podfile to a temp file, modify the Podfile as such: (Assume PRIVATE_POD_NAMESPACE=TP)

    pod 'TPPodname1', :path => '../Podname1/Podname1.podspec'
    pod 'TPPodname2', :path => '../Podname2/Podname2.podspec'
    pod 'TPPodname3', :git => 'https://github.com/MYREPO/TPPodname3.git', :branch => 'development'

It will try to clone the local pods in the folder as shown above using the ENV variable set for GIT_REPO_BASE_URL. It will also alter the other TP pods to point to development branch. And then it will run pod install on that modified Podfile. After that, it will revert back to the original Podfile, so that you don't need worry about your Podfile changing in the git repository, while you are working on it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
