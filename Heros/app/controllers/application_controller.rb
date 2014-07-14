class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protect_from_forgery  
  helper_method :current_user

  def check_if_logged_in
    if (session[:user_id] != nil) && (User.where(:id => session[:user_id]).empty?)
      reset_session
    end  
  	if session[:user_id] == nil
  		redirect_to log_in_path, :notice => "You are not logged in!"	
  	end
  end	

  def check_user
    if (User.find(session[:user_id]).login != "adm")
      redirect_to heros_path, :notice => "You are not administrator"
    end    
  end  
    
  private  
  def current_user
    if (session[:user_id] != nil) && (User.where(:id => session[:user_id]).empty?)
      reset_session
    end  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end
end
