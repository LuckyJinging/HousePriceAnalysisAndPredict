class ArticlesController < ApplicationController
  def show
      @articles = Article.find(1)
  end
  def new
  end
end