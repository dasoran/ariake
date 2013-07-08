# coding: utf-8

class Admin::UsersController < Admin::Base
  def show
    @users = User.all
  end
end
