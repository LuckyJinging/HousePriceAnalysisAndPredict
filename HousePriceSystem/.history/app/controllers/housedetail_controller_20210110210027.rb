class HousedetailController < ApplicationController

    def houseDirection
        @house = Housedetail.find_by_sql('select district,count(*) as cnum,avg(attention) as anum from housedetail group by district')
        render :json => @house,status: '200 OK'
    end
    def houseDecoration
        @house = Housedetail.find_by_sql('select decoration,count(*) as num,avg(unitPrice) as price from housedetail group by decoration')
        render :json => @house,status: '200 OK'
    end
    def houseTagList
        @house = Housedetail.find_by_sql('select tagList,avg(totalPrice) as total from housedetail group by tagList')
        render :json => @house,status: '200 OK'
    end
    def new
    end
end
