class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:sessions][:password])
  		#go to show page
  	else
  		flash.now[:danger] = "Invalid email/password combo"
  		render 'new'
  	end
  end

  def destroy
  end
end
