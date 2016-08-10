require 'open-uri'
require 'nokogiri'
require 'pry'

class Brewery_Fetcher

  def self.query_api(api_query)
    returned_request = Nokogiri::HTML(open(api_query))

    breweries = []
    #we gotta use something called xpath?
    returned_request.xpath("//location").each do |location|
      brewery = {
      :name => location.xpath("child::name").text,
      :street_address => location.xpath("child::street").text,
      :phone => location.xpath("child::phone").text
      }
      #add brewery to breweries
      breweries << brewery
    end

    return breweries
  end

#change to self.fetch_score_info
  def self.fetch_score_info(score_request)
    returned_scores = Nokogiri::HTML(open(score_request))
    #brewery score profile
    score_profile = {
    #overall_score, selection, service, atmosphere, food, review_count, fb_score, fb_count
      :overall_score => returned_scores.xpath("child::overall").value,
      :selection => returned_scores.xpath("child::selection").value,
      :service => returned_scores.xpath("child::service").value,
      :atmosphere => returned_scores.xpath("child::atmosphere").value,
      :review_count => returned_scores.xpath ("child::reviewcount").value,
      :food=>returned_scores.xpath("child::food")
      }

    #return brewery score profile
    return score_profile

  end

end
