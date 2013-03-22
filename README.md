#DEPRECATED#

It's nice getting Windows to behave a lot like Linux, but evetually it dawned on me that the constant battle
with configurations and packages that is needed in order to keep Windows playing nice is just not fun.

I have finally embraced Linux whole heartidly, and I'm deprecating hells-kitchen in favor of [heavens-kitchen](https://github.com/dkinzer/heavens-kitchen).

If you are like me, you probably know your way around the command line pretty well and are happy enough in either
OS.  But ask yourself, exactly how many of the Windows tools do you actually use vs. ported Linux tools?

It's hard to believe I've stuck with Windows for as long as I have.

Try [heavens-kitchen](https://github.com/dkinzer/heavens-kitchen) for Umbutu.  Development is just a smoother more fun experience when you are not in constant
battle with your tools.

____

Hells' Kitchen
==============

A portable package for my Knife-Solo and Vagrant development environment on Windows.  

I origionally forked this from **[Bill's Kitchen](https://github.com/tknerr/bills-kitchen)** -- so make sure you take a look at that project and give them their props. 

I've trimmed down Bill's Kitchen considerably for my specific needs, and I make a couple of substitutions for the dev tools:
  * ConEmu instead of Console2
  * Vim instead of SublimeText.
  * Plus my personal .vim configurations and submodules.
  * No KDiff3 since Vim-Fugitive will take care of all my Git needs.

####Basic gems:
  * [vagrant](http://vagrantup.com/) (patched to make `vagrant ssh` work on windows)
  * [chef-solo](http://www.opscode.com/chef/) (yeah you know what Chef is...)
  * [librarian](https://github.com/applicationsonline/librarian) (dependency management for cookbooks)
    
####Testing-related:
  * [foodcritic](https://github.com/acrmp/foodcritic) (linting for your cookbooks)

####Other:
  * [veewee](https://github.com/jedi4ever/veewee) (for building vagrant baseboxes)
  * [knife-solo](https://github.com/matschaffer/knife-solo)
  * [knife-solo_data_bag](https://github.com/thbishop/knife-solo_data_bag) (knife data bag commands for chef-solo)

####Supporting tools such as:
  * ConEmu
  * Vim
  * Portable Git
  * Putty
  * FileZilla

Requires **[VirtualBox](https://www.virtualbox.org/wiki/Downloads)**.


Installation
============

As a prerequisite for building bill's kitchen you need 7zip installed in `C:\Program Files (x86)\7-ZIP_64_bit\7z.exe`. 

Build the kitchen (make sure you don't have spaces in the path):

```
gem install bundler
bundle install
rake
```

This might take a while (you can go fetch a coffee). It will download the external dependencies and assemble the kitchen in the `target/build` directory, which is then packaged as `target/hells-kitchen-<version>.7z`


Usage
=====

Make sure you have  [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed, then:

1. unzip the `target/hells-kitchen-<version>.7z` somewhere
1. mount the kitchen to the `W:\` drive by double-clicking the `mount-w-drive.bat` file
1. click `W:\ConEmu.lnk` to open a command prompt

