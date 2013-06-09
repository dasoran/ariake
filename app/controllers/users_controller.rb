# coding: utf-8
class UsersController < ApplicationController
  def new
    @user = User.new()
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, success: "登録が完了しました。"
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
end
