class PredictController < ApplicationController
    def predictPrice
        skip_before_filter :verify_authenticity_token
        render plain: params[:idNum].inspect
        
    end
    def new
    end
end
