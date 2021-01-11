class PredictController < ApplicationController
    def predictPrice
        @house = Housedetail.find_by_sql('select district,count(*) as cnum,avg(attention) as anum from housedetail group by district')
        render :json => @house,status: '200 OK'
    end
    def new
    end
end
