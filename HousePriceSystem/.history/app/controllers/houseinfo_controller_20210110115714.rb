class HouseinfoController < ApplicationController
    def houseType
        # @house = Houseinfo.group(:housetype).count
        @house = Houseinfo.find_by_sql('select housetype,count(*) from houseinfo group by housetype order by count(*) desc')
        render :json => @house,status: '200 OK'
    end
    def new
    end
end
