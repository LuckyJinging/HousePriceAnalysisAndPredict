class HouseinfoController < ApplicationController
    def houseType
        # @house = Houseinfo.group(:housetype).count
        @house = Houseinfo.find_by_sql('select housetype,count(*) as count from houseinfo group by housetype')
        render :json => @house,status: '200 OK'
    end
    def new
    end
end
