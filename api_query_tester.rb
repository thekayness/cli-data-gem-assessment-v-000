require 'open-uri'
require 'nokogiri'

api_request = Nokogiri::HTML(open("http://beermapping.com/webservice/loccity/21110efff66df69d91ec3909c0a38eed/providence,ri"))

#change to breweries[]
breweries = []

#we gotta use something called xpath?
api_request.xpath("location").each do |location|
  #brewery
  brewery = {
  :name => api_request.xpath("name").text,
  #street address
  :street_address => api_request.xpath("street").text,
  #phone number
  :phone =>student_card.css("phone").text
  }
  #add brewery to breweries
  brewery << breweries
end

puts "#{breweries}"
