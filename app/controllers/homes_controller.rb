class HomesController < ApplicationController

	def index
		
  end

  def test_ajax
  	respond_to do |format|
  		format.js{render json: { success: true,message: "hiiiiii"}}
  	end 

  end
end
