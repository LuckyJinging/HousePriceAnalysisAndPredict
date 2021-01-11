class HouseinfoController < ApplicationController
    def houseType
        @house = Houseinfo.group(:housetype).count
        
    end
    def new
    end
end
