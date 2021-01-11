class HouseinfoController < ApplicationController
    def houseType
        @house = Houseinfo.group(:housetype).count.:limit => 10 #By default SQL String limit 255 character 
        #Ex:- :limit => 40
        render :json => @house,status: '200 OK'
    end
    def new
    end
end
