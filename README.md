DriveInsomnia
=============

About
=====

Some drives do not respect the power saving settings in Mac OS X.
Drive Insomnia is an App that makes the connected units never sleep. ;)


What DriveInsomnia do?
======================

Basically:
- Create a hidden file on the disk specified by the user;
- Creates a Launch Agent that runs the command 'touch-c' in the hidden file created on disk, every minute, maintaining the disk always awake.

(Insomnia can be reversed.)


Who build this?
==============

DriveInsomnia was built by Jeferson Brito and is completely open source and available https://github.com/jefersonbc/DriveInsomnia. You can also follow @jefersonbc on Twitter where he'll tweet about Ruby and Ruby on Rails, Mac OS, JQuery, Wordpress and CSS/HTML5, plus some hidden treasures.


A short history
===============

I have two external drives that do not obey the power saving settings in Mac OS X, so that even unchecking the option to make disks to sleep, they insist on sleeping.
In this way several times a day, when I need to access them, they are sleeping. Until they are available again, the Mac OS suffers some crashes or slowdowns.
Was thinking of solving this problem that I wrote my first application in Objective-C, the DriveInsomnia.

DriveInsomnia is my first Cocoa application, probably with many flaws and oversights, but it was a great experience to solve a real need.
