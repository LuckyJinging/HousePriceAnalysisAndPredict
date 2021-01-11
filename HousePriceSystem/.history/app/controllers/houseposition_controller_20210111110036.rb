class HousepositionController < ApplicationController

    def getPosition
        @position = Houseposition.find_by_sql('select community,count(*) as num,lat,lng from houseposition group by community')
        render :json => @position,status: '200 OK'
    end
    def new
    end
end
