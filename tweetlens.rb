require 'rubygems'
require 'open-uri'
require 'sinatra'
require 'vendor/htmlentities-4.0.0/lib/htmlentities'
require 'vendor/simple-rss-1.2/lib/simple-rss'
require 'vendor/hashes2ostruct'
SimpleRSS.item_tags << :image

DEFAULT_CONFIG = { "cache_max_age"=>300, "query"=>"" }

CONFIG = hashes2ostruct(DEFAULT_CONFIG.merge((File.exists?('CONFIG.yml') && YAML::load_file('CONFIG.yml')) || {}))

querystring = "q=#{CGI::escape(CONFIG.query)}"
querystring += "&lang=#{CONFIG.language}" if CONFIG.language
querystring += "&rpp=#{CONFIG.count}" if CONFIG.count
querystring += "&geocode=#{CONFIG.count}" if CONFIG.geocode

set :public, File.dirname(__FILE__) + '/sites/default/public'
set :views, File.dirname(__FILE__) + '/sites/default/views'

get '/:site?/?' do |site|
  @feed = SimpleRSS.parse open("http://search.twitter.com/search.atom?#{querystring}").read.gsub('<link type="image/png"','<image')
  headers 'Cache-Control' => "public, max-age=#{CONFIG.cache_max_age}"
  haml :index
end

helpers do
  def decode_html(string)
    HTMLEntities.new.decode(string.gsub('&#8217;','&apos;'))
  end
  
  def fix_search_links(string)
    string.gsub('href="/search?','href="http://search.twitter.com/search?')
  end
  
  def prepare_content(string)
    fix_search_links(decode_html(string))
  end
  
  def extract_author_name(string)
    string.split(/\n/)[0].split(/ /)[0]
  end
end