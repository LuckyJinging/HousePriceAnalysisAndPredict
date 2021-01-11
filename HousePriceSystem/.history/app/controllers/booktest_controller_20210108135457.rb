class BooktestController < ApplicationController
    def show
        @book = Booktest.find(:all)
    end
    def new
    end
end
