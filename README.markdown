After spending a while googling for how to make a ohai plugin I was forced to Read The Source (tm). So I thought I would put to gether a quick ohai plugin howto.

Install ohai
============

You will need the ohai gem installed to use it, so an easy way to do this:

    sudo gem source -a http://gems.opscode.com/
    sudo gem install ohai

Create a simple plugin
======================

Ohai plugins use a ruby DSL. The following is about as simple as it gets:

    provides "orly"
    orly "yeah, rly."

Now that part I found tricky, loading it.

Create a "plugins" folder and put the above code in the [plugins/orly.rb](http://github.com/csexton/ohai-plugin-howto/blob/master/plugins/orly.rb) file.

Now to fire up irb (I am assuming you are in the directory that contains the "plugins" folder, if not adjust your path):

    >> require 'ohai'
    >> Ohai::Config[:plugin_path] << './plugins'
    >> o = Ohai::System.new
    >> o.all_plugins
    >> o.orly #=> "yea, rly"

The entire script can be found in [orly.rb](http://github.com/csexton/ohai-plugin-howto/blob/master/orly.rb)

If you run `o.orly` and get `nil` the chances are the plugin path is probably incorrect. I battled with this for hours banging my head against the wall. Turns out I just forgot the 's' on the end of './plugins'

Using a Mash
============

Most of the information we want to lookup would be nested in some way, and ohai tends to do this by storing the data in a Mash. This can be done by creating a new mash and setting the attribute to it.

In [plugins/canhas.rb](http://github.com/csexton/ohai-plugin-howto/blob/master/plugins/canhaz.rb):

    provides "canhas"
    canhas Mash.new
    canhas[:burger] = "want"

Extending an existing plugin
============================

Ohai makes it very easy to extend a current plugin with new information. Simply require the plugin you want to extend and extend away. In this example we want to add LOLCODE to languages.


In [plugins/lolcode.rb](http://github.com/csexton/ohai-plugin-howto/blob/master/plugins/lolcode.rb):

    provides "languages/lolcode"
    require_plugin "languages"
    languages[:lolcode] = Mash.new
    languages[:lolcode][:version] = "TEH VERSHIONS"

Working with Different Platforms
================================


One of the main reasons for using ohai is to gather information regardless of the operating system, luckily this is made easy by optionally loading recipes based on the platform. With that platform specific calls abstracted away you can keep your code DRY.

The builtin plugins that come with ohai use the following trick to load platform specific code. It works by creating a base cross-platform plugin that loads the platform specific plugin from a subdirectory.


In [plugins/lolcode.rb](http://github.com/csexton/ohai-plugin-howto/blob/master/plugins/lolcode.rb):

    provides "languages/lolcode"
    require_plugin "languages"
    require_plugin "#{os}::lolcode"

    languages[:lolcode] = Mash.new unless languages[:lolcode]
    languages[:lolcode][:version] = "TEH VERSHIONS"

In [plugins/darwin/lolcode.rb](http://github.com/csexton/ohai-plugin-howto/blob/master/plugins/darwin/lolcode.rb):

    provides "languages/lolcode"
    require_plugin "languages"
    languages[:lolcode] = Mash.new unless languages[:lolcode]
    languages[:lolcode][:platform] = "MACKERS"

Checkout ohai's [os.rb](http://github.com/opscode/ohai/blob/master/lib/ohai/plugins/os.rb) for the list of platform names.

All of these examples can be found in the [ohai-plugin-howto github repo](http://github.com/csexton/ohai-plugin-howto/), you should be able to clone that and run the ruby scripts in the repo's root directory.
