RSSTicker.sh
==============

This is a simple bash RSS feed ticker for your DropBox account. 

I personally have a lot of shared folders with co-workers and if I'm away from my desk I can miss the little pop-up from DropBox saying files have been added. Plus this pop-up doesn't always tell me *what* files have actually been added. 

Instead I run this little script in a spare terminal and it will tell me exactly what has happened in my DropBox and when.

NOTES:
* I use the program todo.txt and found it really cluttered up my DropBox feed. This script ignores any changes involving todo.txt
* I also added a function that changes the time stamp into the timezone of your system clock.
* To find your DrobBox RSS feed log into the DropBox website and click on "Events". At the bottom of this page there will be a link for your RSS feed.

Enjoy

Contributing
------------

Feel free to fork and send [pull requests](http://help.github.com/fork-a-repo/).  Contributions welcome.

Credit
------------

This script was originally inspired by the heise-ticker.sh from Sixgun Productions <fab@sixgun.org>

License
-------

This script is open source software released under the GNU GENERAL PUBLIC LICENSE V3.

Tips and Tricks
------------

**Access RSSTicker.sh from anywhere in the file tree.**

Add the following to your `~/.bashrc` file (`~/.bash_profile` for Mac and Cygwin users):

<pre>
alias rss='/path/to/RSSTicker.sh'
</pre>

Run `source ~/.bashrc` to reload your changes.

Now you simply type `rss` from anywhere in your file tree to open RSSTicker.