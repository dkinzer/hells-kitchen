
Hells' Kitchen
==============

A portable package for my Chef and Vagrant development environment on Windows.  
I origionally forked this from [Bill's Kitchen](https://github.com/tknerr/bills-kitchen) -- so make sure you take a look at that project and give them their props. 

I've trimmed down Bill's Kitchen considerably for my specific needs, and I make a couple of substitutions for the dev tools:
  * ConEmu instead of Console2
  * Vim instead of SublimeText.
  
  * Pre-configured Chef Repo with Vagrantfile to bring up a ready-to-use Chef Server 
  * devkit enhanced Ruby 1.9.3 ([TCS-Ruby](https://github.com/thecodeshop/ruby/wiki/Downloads), load time improvements >50%!) with lots of useful gems pre-installed:
 
  * basic gems:
 		* [vagrant](http://vagrantup.com/) (patched to make `vagrant ssh` work on windows)
 		* [chef-solo](http://www.opscode.com/chef/) (yeah you know what Chef is...)
    * [librarian](https://github.com/applicationsonline/librarian) (dependency management for cookbooks)
    
  * Testing-related:
 		* [foodcritic](https://github.com/acrmp/foodcritic) (linting for your cookbooks)
 		* [chefspec](https://github.com/acrmp/chefspec) (rspec examples for chef-run/cookbooks)
    * [test-kitchen](https://github.com/opscode/test-kitchen) (the "holistic test runner" from Opscode)

 	* Other:
 		* [veewee](https://github.com/jedi4ever/veewee) (for building vagrant baseboxes)
    * [knife-solo](https://github.com/matschaffer/knife-solo)
    * [knife-solo_data_bag](https://github.com/thbishop/knife-solo_data_bag) (knife data bag commands for chef-solo)
 
  * Supporting tools such as:
 	  * ConEmu
    * Vim
    * Portable Git
    * Ubunto Mono-Type font

Requires [VirtualBox](https://www.virtualbox.org/wiki/Downloads).


Installation
============

As a prerequisite for building bill's kitchen you need 7zip installed in `C:\Program Files\7-Zip\7z.exe`.

Build the kitchen (make sure you don't have spaces in the path):

```
gem install bundler
bundle install
rake build
```

This might take a while (you can go fetch a coffee). It will download the external dependencies and assemble the kitchen in the `target/build` directory, which is then packaged as `target/bills-kitchen-<version>.7z`


Usage
=====

Make sure you have  [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed, then:

1. unzip the `target/hells-kitchen-<version>.7z` somewhere
1. mount the kitchen to the `W:\` drive by double-clicking the `mount-w-drive.bat` file
1. click `W:\Launch Console.lnk` to open a command prompt
1. in the command prompt run `W:\set-env.bat` to set up the PATH etc 
