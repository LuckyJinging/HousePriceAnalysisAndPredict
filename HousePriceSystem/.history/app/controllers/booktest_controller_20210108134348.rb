class BooktestController < ApplicationController
    def show
        @book = Booktest.find(1)
    end
end
