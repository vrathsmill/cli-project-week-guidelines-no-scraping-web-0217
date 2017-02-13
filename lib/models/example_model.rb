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
