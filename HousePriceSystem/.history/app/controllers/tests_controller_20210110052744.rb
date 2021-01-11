class TestsController < ApplicationController
  def mytest
    json_str = {houseId:'H0001',communityName:'湖畔新城',
                houseSize:'120.0',housePrice:'123.4'}
    render :json => json_str,status: '200 OK'
  end

end
