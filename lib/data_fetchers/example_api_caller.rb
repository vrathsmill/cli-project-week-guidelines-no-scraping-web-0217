class Fetcher

  attr_reader :url, :article_data, :input

  def initialize(url, input)
    @url = url
    @input = input
    @article_data = JSON.parse(RestClient.get(url).body)
  end


  def make_articles

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


end
