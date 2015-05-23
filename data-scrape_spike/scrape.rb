require 'nokogiri'
require 'open-uri'


# years = 1939..2015.to_a

years = (1985..2015).to_a
names = ['East', 'West', 'Midwest', 'South', 'National']

data = {}

  years.each do |year|

  url = "http://www.sports-reference.com/cbb/postseason/#{ year }-ncaa.html"
  doc = Nokogiri::HTML(open(url))

  sleep 1

  data[year] = {url: url}

  names.each do |name|
    data[year][name] = doc.css("##{name}").css('p').map { |game| game.text }
  end

end

require 'json'
File.write('data.json', data.to_json)
