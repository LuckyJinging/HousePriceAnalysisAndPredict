class HouseinfoController < ApplicationController
    def houseType
        @house = Houseinfo.group(:housetype).count
        render :json => @house,status: '200 OK'
    end
    def new
    end
end
