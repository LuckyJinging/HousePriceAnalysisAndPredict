class HousepositionController < ApplicationController

    def getPosition
        @position = Houseposition.find_by_sql('select community,lng,count(*) as num from houseposition group by community')
        render :json => @position,status: '200 OK'
    end
    def new
    end
end
