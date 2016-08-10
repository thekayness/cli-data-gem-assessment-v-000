require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInteface
#change this to base api query
  BASE_PATH = "http://beermapping.com/webservice/"
  KEY = "21110efff66df69d91ec3909c0a38eed"

#what do we want to happen?
  def run
    #first welcome user
    puts "\e[H\e[2J"
    puts <<-DOC
                      o©ºº©oo©oº°©
                      /           \
                      |___________|____
                      |            |____)
                      |  WELCOME   |  | |
                      |            |  | |
                      |    TO      |  | |
                      |            |  | |
                      |  B R E W   |  | |
                      |            |__|_|
                      |   FINDER!  |____)
                      |____________|
                     (______________)
    DOC
    #first ask user for location query
    get_search_query
    format_location_query(city_state_formatted)
    #use results from get_query to get matching breweries
    #change to get_breweries
    get_breweries(location_query)
    #display_matching_breweries
    display_breweries
    #ask user for a brewery/breweries they want to learn more about
    get_score_query
    format_score_query(id)
    get_brewery_score(score_query)
    #display brewery's additional info
    display_score
  end


#make a method that asks for a city/state to query & formats for api request
  #method name: get_query

  def get_location_query
    puts "Please enter the initials of a state you would like to search in:"
    until state.match(/^(?:(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]))$/)
      state = gets.chomp.downcase
      puts "A valid state abbreviation is two letters."
    end

    puts "Now enter a city:"
    city = gets.chomp.downcase

    city_state_formatted = '/' + city + ',' + state
  end

  def format_location_query(location)
    location_query = BASE_PATH + '/loccity/' + KEY + location
  end

  def get_score_query
    puts "Which brewery would you like to learn more about?"
    until id.match(/(\d{4,6})/)
      puts "A valid brewery id is between 4 and 6 digits:"
      id = gets.chomp
    end
    return id
  end

  def format_score_query(brewery_id)
    score_query = BASE_PATH + '/locscore/' + KEY + '/' brewery_id
  end

#grab brewery objects from API
  def get_breweries(location_query)
    brewery_array = Brewery_Fetcher.query_api(location_query)
    #create instances of breweries from each brewery fetched
    Brewery.create_from_collection(brewery_array)
  end

  def brewery_to_score(score_query)
    id_from_query = score_query
    Brewery.all.
#take the requested brewery and add additional info
  def get_brewery_score(score_query)
    #take the brewery instance and give it more attributes
    scores = Brewery_Fetcher.fetch_score_info(score_query)

  end

  def display_breweries
    Brewery.all.each do |brewery|
      puts "#{brewery.name}".colorize(:purple)
      puts "#{brewery.id}".colorize(:green)
      puts "#{brewery.street_address}".colorize(:blue)
      puts "#{brewery.phone}".colorize(:orange)
    end
  end

#display additional requested brewery info
  def display_score
    Brewery.
    end
  end

end
