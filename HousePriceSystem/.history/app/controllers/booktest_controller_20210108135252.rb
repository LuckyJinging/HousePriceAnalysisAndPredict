class BooktestController < ApplicationController
    def show
        @book = Booktest.find(book_id: ISBN0000000001)
    end
    def new
    end
end
