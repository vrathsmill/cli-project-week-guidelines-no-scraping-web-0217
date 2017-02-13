require 'pry'
require 'rest-client'
require 'json'

class CLI

  def call
    puts "*" * 50
    puts "Welcome, what topic would you like to read from The Guardian?"
    puts "Enter 1 for Politics"
    puts "Enter 2 for Art and Design"
    puts "Enter 3 for Film"
    puts "Enter 4 for Business"
    puts "Enter 5 for Football"
    puts "*" * 50
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    print "New search keyword: "
    input = get_user_input
    input = input.to_i

    if input == "help"
      help
    elsif input == "exit"
      #break
      exit
    elsif input < 6 && input > 0
      puts "Please provide a date with format (1999-01-01)"
      input2 = gets.chomp
      search(input, input2)
    else
      run
    end
    # run
  end

  def search(input,input2)
    #search_term = input.split(" ").join("%20").downcase.to_i
    array = ["Politics", "Art and design", "Film", "Business", "Football"]
    #if input == index + 1

  answer = ''
  array.each_with_index do |number,index|
      index = index.to_i + 1
      if index == input
        answer += array[input - 1]
        #run
      end
        # puts "#{input} #{index}Invalid option, please try again."
        #run
    end
    #final array of hashes of articles
    final_hash = []
    puts "Your search term was #{answer}, I am searching..."
    url = "https://content.guardianapis.com/search?api-key=f9262f8b-ecb7-4c13-8878-8da85907e3d7"
    i = 1
    date = "&from-date=" + input2
    #find all of the articles up to the date listed
    #iterate through the pages
    #store them in array of hashes
    final_url = url + date + "&page=" + i.to_s
    final_article = Fetcher.new(final_url, answer).make_articles

    while i < 150
          # date = "&from-date=" + input2 + "&page=" + i.to_s
          i += 1
          final_url = url + date + "&page=" + i.to_s
          final_article = Fetcher.new(final_url, answer).make_articles

          final_article.each do |hash|
            if hash["sectionName"] == answer
              puts "*" * 50
              #puts i + ")"
              puts hash["webTitle"]
              puts hash["webUrl"]
            end

        end
          #   puts final_article["webTitle"]
          #   puts final_article["webUrl"]
          # end
          # puts final_url
          # puts final_article #["results"]["sectionName"]
          #  final_hash << final_article
    end
    # return final_hash
    puts "Thank you for your patience. Here are all of the articles I found on the Guardian:"

    # articles.find do |article|
    #   if article['response']['results']['sectionName'] == answer
    #     puts article['response']['results']['webTitle']
    #     puts article['response']['results']['webUrl']


  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type 'random' for a random article"
    puts "Type '' for something "
  end

  def exit
    return "Goodbye!"
  end

end

class Fetcher

  attr_reader :url, :article_data, :input

  def initialize(url, input)
    @url = url
    @input = input
    @article_data = JSON.parse(RestClient.get(url).body)
  end

  # def get_input
  #   @input = input
  # end

  def make_articles
    # input = get_input
    articles = []
    result = []
    all_articles = self.article_data["response"]["results"]
    articles << all_articles
    all_articles.each do |hash|
        article_name = hash["webTitle"]
        article_url = hash["webUrl"]
        articles << Article.new(article_name, article_url)
    end
  end
    # puts "*" * 50

    #Article.all.map{|article| puts article.article_name, article.article_url}
    # i = 1
    # articles.each do |array|
    #
    #   array.each do |hash, index|
    #     if hash["sectionName"] == input
    #       puts "#{i}. #{hash["webTitle"]}"
    #       puts "#{hash["webUrl"]}"
    #       i += 1
    #     end
    #   end
    # end


end




  class Article

    attr_accessor :article_name, :article_url
    @@articles = []
    def initialize(article_name, article_url)
      @article_name = article_name
      @article_url = article_url
      @@articles << self
    end

    def self.all
      @@articles
    end

  end


 # binding.pry
