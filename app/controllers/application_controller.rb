class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :authorize


  #private
  #def authorize
  #  if session[:user_id]
  #    @current_user = User.find_by_id(session[:user_id])
  #    session.delete(:user_id) unless @current_member
  #  end
  #end
end
