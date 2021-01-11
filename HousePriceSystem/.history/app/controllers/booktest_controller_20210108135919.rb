class BooktestController < ApplicationController
    def show
        @book = Booktest.find_by_sql('select * from book')
    end
    def new
    end
end
