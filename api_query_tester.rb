require 'open-uri'
require 'nokogiri'

api_request = Nokogiri::XML(open("http://beermapping.com/webservice/loccity/21110efff66df69d91ec3909c0a38eed/providence,ri"))
#change to breweries[]
breweries = []
#puts "#{api_request}"
#we gotta use something called xpath?
api_request.xpath("//location").each do |location|
  brewery = {
  :name => location.xpath("child::name").text,
  :street_address => location.xpath("child::street").text,
  :phone => location.xpath("child::phone").text
  }
  #puts "#{brewery}"
  #add brewery to breweries
  breweries << brewery
end

puts "#{breweries}"
