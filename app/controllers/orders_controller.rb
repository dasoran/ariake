# coding: utf-8
class OrdersController < ApplicationController
  def update_all
    is_change = false
    params.each do |key, param|
      next unless key.split("-")[0] == "quantity"
      quantity = param.to_i
      order_id = key.split("-")[1].to_i
      order = Order.find_by_id(order_id)
      next if order.quantity == quantity
      if quantity == 0 then
        order.destroy
      else
        order.quantity = quantity
        order.save
      end
      is_change = true
    end
    if is_change then
      flash[:success] = "希望を変更しました。"
    else 
      flash[:info] = "変更する個数を変更してから更新ボタンを押してください。"
    end
    if params[:is_admin]
      redirect_to admin_entry_path(params[:entry_id])
    else
      redirect_to entry_path(params[:entry_id])
    end
  end
  def create_from_link
    handout_id = params[:handout_id]
    order = Order.new
    order.user_id = @current_user.id
    order.handout_id = handout_id
    order.quantity = 1
    order.save
    flash[:success] = "希望を追加しました。"
    if params[:is_admin]
      redirect_to admin_entry_path(params[:entry_id])
    else
      redirect_to entry_path(params[:entry_id])
    end
  end
end
