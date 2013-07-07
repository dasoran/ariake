# coding: utf-8
class UsersController < ApplicationController
  def new
    @user = User.new()
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to :root, success: "登録が完了しました。"
    else
      flash[:error] = "エラー：フォームの入力事項を確認してください。"
      render "new"
    end
  end
  def login
    if @current_user
      redirect_to :root
    end
  end
  def entries
    @event = Event.find_by_name("C84") 
    @user = User.find_by_login_id(params[:id])

    @day = params[:day]
    if @day == "1" || @day == "2" || @day == "3"
      @entries = Entry.includes(:handouts => :orders).includes(:map_layout).where("map_layouts.event_id = %d and attend_at = %d and orders.user_id = '%s'" % [@event.id, @day, @user.id]).uniq
    else
      @entries = Entry.includes(:handouts => :orders).includes(:map_layout).where("map_layouts.event_id = %d and orders.user_id = '%s'" % [@event.id, @user.id]).uniq
    end

  end
end
