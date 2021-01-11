class HousepositionController < ApplicationController

    def getPosition
        @position = Houseposition.find_by_sql('select community,lng,lat,count(*) as num from houseposition group by community,lng,lat')
        render :json => @position,status: '200 OK'
    end
    def new
    end
end
