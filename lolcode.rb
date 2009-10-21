#!/usr/bin/env ruby

require 'rubygems'
require 'ohai'
Ohai::Config[:plugin_path] << File.join(File.dirname(__FILE__),  'plugins')

o = Ohai::System.new
o.all_plugins
p o.languages['lolcode']

