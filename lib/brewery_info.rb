#change to Brewery
class Student

  #change to reflect all brewery attributes
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send(("#{key}="), value)
      @@all << self
    end
  end

  #change students_array to brewery_array
  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      #Brewery.new
      Student.new(student_hash)
    end
  end

  #change to score_hash
  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send(("#{key}="), value)
    end
  end

  def self.all
    @@all
  end
end
