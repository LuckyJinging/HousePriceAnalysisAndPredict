class ArticlesController < ApplicationController
  def show
      @articles = Article.find()
  end
  def new
  end
end