class PredictController < ApplicationController
    protect_from_forgery :except => :predictPrice
    # skip_before_filter :verify_authenticity_token
    def predictPrice
        
        render plain: params[:idNum].inspect
        
    end
    def new
    end
end
