# This file goes in domain.com/config.ru

require 'sinatra'
require 'rubygems'

path = "/home/reidab/sites/afterhours.reidab.com"

Sinatra::Application.default_options.merge!(
  :root => path,
  :views => path + '/views',
  :public => path + '/public',
  :run => false,
  :env => :production 
)

log = File.new("sinatra.log", "w")
STDOUT.reopen(log)
STDERR.reopen(log)

require 'afterhours.rb'
run Sinatra.application
