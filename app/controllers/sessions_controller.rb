class SessionsController < ApplicationController

  def new
  end

  def create

    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
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

  private

  def log_in(user)
    session[:user_id] = user.id
    Rails.logger.info "Session set for user: #{session[:user_id]}"
  end

  def log_out
    Rails.logger.info "Logging out user: #{session[:user_id]}"
    session.delete(:user_id)
    @current_user = nil
    Rails.logger.info "Session cleared for user: #{session[:user_id]}" 
  end

end
