$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/vendor/simple-rss-1.2/lib')
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/vendor/htmlentities-4.0.0/lib')

require 'tweetscope'
run Sinatra::Application
