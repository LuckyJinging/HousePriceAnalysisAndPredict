class PredictController < ApplicationController
    def predictPrice
        render plain: params[:idNum].inspect
        skip_before_filter :verify_authenticity_token
    end
    def new
    end
end
