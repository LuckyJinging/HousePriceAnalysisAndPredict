class HousedetailController < ApplicationController

    def houseDirection
        @house = Housedetail.find_by_sql('select district,count(*) as cnum,sum(attention) as anum from housedetail group by district')
        render :json => @house,status: '200 OK'
    end
    def houseAttention
        @house = Housedetail.find_by_sql('select district,sum(attention) as num from housedetail group by district')
        render :json => @house,status: '200 OK'
    end
    def new
    end
end
