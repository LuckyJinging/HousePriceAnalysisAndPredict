class ArticlesController < ApplicationController
  def show
      # @book = Book.find(1);
      @articles = Article.find(1)
  end
  def new
  end
end