class SessionsController < ApplicationController

  def new
  end

  def create

    if user = User.authenticate_with_credentials(params[:session][email], params[:session][:password])
      log_in(user)
      Rails.logger.info "User logged in: #{session[:user_id]}"
      redirect_to root_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = 'Invalid email or password'
      render 'new'
    end

  end

  def destroy
    log_out()
    Rails.logger.info "User logged out: #{session[:user_id]}" 
    redirect_to root_path, notice: 'Logged out successfully!'
  end

end
