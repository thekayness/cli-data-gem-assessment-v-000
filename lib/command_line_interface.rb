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
    #use results from get_query to get matching breweries
    #change to get_breweries
    get_request(query_type)
    #display_matching_breweries

    #ask user for a brewery/breweries they want to learn more about
    #get_requested_brewery

    #change to get_brewery_info
    add_attributes_to_students
    #display brewery's additional info
    #change to display_brewery_info
    display_students
  end


#make a method that asks for a city/state to query & formats for api request
  #method name: get_query

  def get_search_query
    puts "Please enter the initials of a state you would like to search in:"
    until state.match(/^(?:(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]))$/)
      state = gets.chomp.downcase
      puts "A valid state abbreviation is two letters."
    end
    state_formatted = '/' + state + ','

    puts "Now enter a city:"
    city = gets.chomp.downcase

    query_type = BASE_PATH + 'loccity/' + KEY + state_formatted + city
  end
#grab brewery objects from API
  def get_request(query_type)
    breweries_array = Brewery_Fetcher.query_api(query_type)
    #create instances of breweries from each brewery fetched
    Brewery.create_from_collection(brewery_array)
  end

#make a method that displays only breweries returned

#take the requested brewery and add additional info
  def add_attributes_to_students
    #take the brewery instance and give it more attributes using brewery info class
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(student.profile_url)
      student.add_student_attributes(attributes)
    end
  end

  def display_breweries
    Brewery.all.each do |brewery|
      puts "#{brewery.name}".colorize(:purple)
      puts "#{brewery.id}".colorize(:green)
      puts "#{brewery.street_address}".colorize(:blue)
      puts "#{brewery.phone}".colorize(:orange)
    end

#display additional requested brewery info
  def display_students
    Student.all.each do |student|
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  location:".colorize(:light_blue) + " #{student.location}"
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
      puts "  bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  github:".colorize(:light_blue) + " #{student.github}"
      puts "  blog:".colorize(:light_blue) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end

end
