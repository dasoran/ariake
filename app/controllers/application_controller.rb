class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  class Forbidden < StandardError; end
  class NotFound < StandardError; end



  private
  def authorize
    if session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
      if @current_user.permission == "stop"
        session.delete(:user_id)
        redirect_to :root
      end
      session.delete(:user_id) unless @current_user
    end
  end
  def login_required
    raise Forbidden unless @current_user
  end


  if Rails.env.production?
    rescue_from Exception, with: :rescue_500
    rescue_from ActionController::RoutingError, with: :rescue_404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
  end
  rescue_from Forbidden, with: :rescue_403
  rescue_from NotFound, with: :rescue_404

  def rescue_500
    render "errors/internal_server_error", status:500
  end

  def rescue_404
    render "errors/not_found", status:404
  end

  def rescue_403
    render "errors/forbidden", status:403
  end



end

