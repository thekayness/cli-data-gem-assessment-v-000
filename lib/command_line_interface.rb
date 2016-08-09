require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInteface
#change this to base api query
  BASE_PATH = "./fixtures/student-site/"

#what do we want to happen?
  def run
    #first ask user for location query
    #wget_query

    #use results from get_query to get matching breweries
    #change to get_breweries
    make_students

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

#grab brewery objects from API
  def make_students
    #shove breweries into brewery array using brewery fetcher
    #change scrape_index_page method to query_api, change index.html to get_query
    students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
    #create instances of breweries from each brewery fetched
    Student.create_from_collection(students_array)
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
