#!/usr/bin/env ruby 

require 'rubygems'
require 'ohai'
Ohai::Config[:plugin_path] << File.join(File.dirname(__FILE__),  'plugins')

o = Ohai::System.new
o.require_plugin 'orly'
puts o.orly

