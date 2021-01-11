class PredictController < ApplicationController
    def predictPrice
        render plain: params[:idNum].inspect
    end
    def new
    end
end
