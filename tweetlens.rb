require 'rubygems'
require 'open-uri'
require 'sinatra'
require 'vendor/simple-rss-1.2/lib/simple-rss'
require 'vendor/htmlentities-4.0.0/lib/htmlentities'

SimpleRSS.item_tags << :image


get '/' do
  @feed = SimpleRSS.parse open('http://search.twitter.com/search.atom?q=%23afterhours&rpp=20').read.gsub('<link type="image/png"','<image')
  headers 'Cache-Control' => 'public, max-age=300'
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
