class ArticlesController < ApplicationController
  def show
      @articles = Article.find(params[:id])
  end
  def new
  end
end