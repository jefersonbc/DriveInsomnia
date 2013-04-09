DriveInsomnia for Mac OS X
==========================

About
=====

Some drives do not respect the power saving settings in Mac OS X.
Drive Insomnia is an App that makes the connected units never sleep. ;)

(Beware, still unfinished!)


What DriveInsomnia do?
======================

Basically:
- Create a hidden file on the disk specified by the user;
- Creates a Launch Agent that runs the command 'touch-c' to access and modification times of the file created on disk, every minute, maintaining the disk always awake.

(Insomnia can be reversed.)


Who build this?
==============

DriveInsomnia was built by Jeferson Brito and is completely open source and available on https://github.com/jefersonbc/DriveInsomnia.
DriveInsomnia is my first Cocoa application, probably with many flaws and oversights, but it was a great experience to solve a real problem.

You can also follow Jeferson Brito on Twitter (https://twitter.com/jefersonbc) or Facebook (http://www.facebook.com/jefersonbc), where he'll talk about Ruby and Ruby on Rails, Mac OS, JQuery, Wordpress and CSS/HTML5, plus some hidden treasures.


A short history
===============

I have two external drives that do not obey the power saving settings in Mac OS X, so that even unchecking the option to make disks to sleep, they insist on sleeping.
In this way several times a day, when I need to access them, they are sleeping. Until they are available again, the Mac OS suffers some crashes or slowdowns.
Was thinking of solving this problem that I wrote my first application in Objective-C, the DriveInsomnia.
