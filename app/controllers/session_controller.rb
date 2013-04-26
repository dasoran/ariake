# coding: utf-8

class SessionController < ApplicationController
  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
    else
      flash.alert = "ログイン情報が間違っています"
    end
    redirect_to :root
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end
end
