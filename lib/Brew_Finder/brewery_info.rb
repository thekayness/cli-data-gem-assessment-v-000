#change to Brewery
class Brewery

  #change to reflect all brewery attributes
  attr_accessor :name, :street_address, :phone, :id, :overall_score, :selection, :service, :atmosphere, :review_count, :food

  @@all = []

  def initialize(brewery_hash)
    #puts "#{brewery_hash}"
    count = 0
    brewery_hash.each do |key, value|
      #puts "#{key}: #{value}"
      #value.each do |key,value|
      #  puts "#{key},#{value}"
      #end
      #puts "count = #{count}"
      count += 1
      self.send(("#{key}="), value)
      #puts "#{self.street_address}"

    end
    @@all << self
    #puts "#{self.inspect}"
  end

  #change students_array to brewery_array
  def self.create_from_collection(brewery_array)
    #puts "#{brewery_array}"
    brewery_array.each_with_index do |brewery_hash, index|
      #Brewery.new
      #puts "#{brewery_hash} #{index}"
      Brewery.new(brewery_hash)
      #puts "#{self.name} #{self.id}"
    end
  end

  #change to add_brewery_info, score_hash
  def add_score_info(score_hash)
    if (score_hash == nil)
      #puts "nildorado"
    end
    #puts "#{score_hash}"
    score_hash.each do |key, value|
      self.send(("#{key}="), value)
      #puts "#{key}= #{value}"
    end
  end

  def self.all
    @@all
  end
end
