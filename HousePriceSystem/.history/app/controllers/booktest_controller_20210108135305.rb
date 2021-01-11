class BooktestController < ApplicationController
    def show
        @book = Booktest.find(ISBN0000000001)
    end
    def new
    end
end
