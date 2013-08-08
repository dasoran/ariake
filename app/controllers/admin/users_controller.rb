# coding: utf-8

class Admin::UsersController < Admin::Base
  def show
    @users = User.all
    @color_list = [
      "#000000", "#800000", "#008000", "#000080",
      "#808080", "#ff0000", "#00ff00", "#0000ff",
      "#c0c0c0", "#808080", "#808000", "#008080",
      "#ffffff", "#ff00ff", "#ffff00", "#00ffff"
    ]
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    @user.save

    flash[:success] = "ユーザーを削除しました。"
    redirect_to admin_user_path
  end

  def change_permission
    #user = User.find_by_id(params[:user_id])
    #user.assign_attributes({"administrator" => (params[:admin] == 'true' ? true : false)}, as: :admin)
    #user.save
    is_changed = false
    params.each do |key, value|
      param_name, user_id = key.split("-")
      next unless param_name == "color" || param_name == "permission"
      user = User.find_by_id(user_id)

      if param_name == "color" 
        unless user.color == value
          user.assign_attributes({"color" => value}, as: :admin)
          user.save
          is_changed = true
        end
      elsif param_name == "permission"
        unless user.permission == value
          user.assign_attributes({"permission" => value}, as: :admin)
          user.save
          is_changed = true
        end
      end
    end

    if is_changed
      flash[:success] = "ユーザー情報を変更しました。"
    else
      flash[:info] = "変更はありません。"
    end
    redirect_to admin_user_path
    end
end
