class HousepositionController < ApplicationController

    def getPosition
        @position = Houseposition.find_by_sql('select community,lng,lat,count(*) as num,price,year,district from houseposition group by community,lng,lat,price,year,district')
        render :json => @position,status: '200 OK'
    end
    def new
    end
end
