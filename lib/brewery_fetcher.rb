require 'open-uri'
require 'nokogiri'
require 'pry'

#change to Brewery_Fetcher
class Scraper

#change to self.query_api, change index_url to api_query
  def self.scrape_index_page(index_url)
    url = Nokogiri::HTML(open(index_url))

    #change to breweries[]
    students = []

    url.css("div.student-card").each do |student_card|
      #brewery
      student = {
      :name => student_card.css("h4.student-name").text,
      #street address
      :location => student_card.css("p.student-location").text,
      #city, state, zip?
      :profile_url =>"./fixtures/student-site/" + student_card.css("a").attribute("href").value
      }
      #add brewery to breweries
      students << student
    end
    #return breweries
    return students
  end

#change to self.fetch_score_info
  def self.scrape_profile_page(profile_url)
    url = Nokogiri::HTML(open(profile_url))
    #brewery score profile
    student_profile = {}

    #change to reflect in depth score attributes
    #overall_score, selection, service, atmosphere, food, review_count, fb_score, fb_count
    links = url.css("div.social-icon-container a")
    links.each do |link|

      link_text = link.attribute("href").value
      if (link_text.include?("github"))
        student_profile[:github] = link_text

      elsif (link_text.include?("twitter"))
        student_profile[:twitter] = link_text

      elsif (link_text.include?("linkedin"))
        student_profile[:linkedin] = link_text

      else
        student_profile[:blog] = link_text

      end
    end

    student_profile[:bio] = url.css("div.bio-content p").text

    student_profile[:profile_quote] = url.css("div.profile-quote").text

    #return brewery score profile
    return student_profile

  end

end
