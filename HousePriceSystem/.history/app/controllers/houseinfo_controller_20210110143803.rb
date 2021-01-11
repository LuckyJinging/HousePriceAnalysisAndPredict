class HouseinfoController < ApplicationController
    def houseType
        # @house = Houseinfo.group(:housetype).count
        @house = Houseinfo.find_by_sql('select housetype,count(*) as num from houseinfo group by housetype order by count(*) desc')
        render :json => @house,status: '200 OK'
    end
    def houseDirection
        @house = Houseinfo.find_by_sql('select ')
    end
    def houseAttention

    end
    def new
    end
end
