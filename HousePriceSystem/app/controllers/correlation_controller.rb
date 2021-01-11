class CorrelationController < ApplicationController

    def getCorrelation
        @corr = Correlation.find_by_sql('select * from correlation')
        render :json => @corr,status: '200 OK'
    end
    def new
    end
end
