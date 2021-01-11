class PredictController < ApplicationController
    def predictPrice
        render plain: params[:predict].inspect
    end
    def new
    end
end
