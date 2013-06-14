# coding: utf-8

class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:login_id], params[:password])
    if user
      session[:user_id] = user.id
    else
      flash[:error] = "ログイン情報が間違っています"
    end
    redirect_to user_path(user.login_id)
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end
end
