class PredictController < ApplicationController
    def predictPrice
        render plain: params[:id].inspect
    end
    def new
    end
end
