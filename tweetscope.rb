require 'rubygems'
require 'open-uri'
require 'sinatra'
require 'lib/config_reader'
require 'vendor/htmlentities-4.0.0/lib/htmlentities'
require 'vendor/simple-rss-1.2/lib/simple-rss'
SimpleRSS.item_tags << :image

config = ConfigReader.read

get '/:site?/?' do |site| 
  site ||= config['_domains'][request.env['SERVER_NAME']] || config['_global']['default_site'] || config.keys.reject{|k| k[0]==95 }.first
  
  raise Sinatra::NotFound unless config.has_key?(site)
  set :views, File.dirname(__FILE__) + "/sites/#{site}"
  @site = config[site]
  
  querystring = ''
  querystring += "q=#{CGI::escape(@site['query'])}" if @site['query']
  querystring += "&lang=#{@site['language']}" if @site['language']
  querystring += "&rpp=#{@site['language']}" if @site['language']
  querystring += "&geocode=#{@site['geocode']}" if @site['geocode']
    
  @feed = SimpleRSS.parse open("http://search.twitter.com/search.atom?#{querystring}").read.gsub('<link type="image/png"','<image')
  headers 'Cache-Control' => "public, max-age=#{@site['cache_max_age'] || config['_global']['cache_max_age']}"
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