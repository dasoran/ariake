# coding: utf-8
class HandoutsController < ApplicationController
  def new
    @entry = Entry.find_by_id(params[:entry_id])
    @goods = Goods.all
    @is_admin = params[:is_admin]
  end
  def create
    if params[:in_generic] == "true"
      if params[:goods_id].nil?
        flash[:info] = "頒布物が選択されていません"
        return redirect_to new_handout_path(:entry_id => params[:entry_id])
      end
      handout = Handout.new
      handout.entry_id = params[:entry_id]
      handout.goods_id = params[:goods_id]
      handout.save
    else
      if params[:name] == "" || params[:price] == ""
        flash[:info] = "頒布物名、価格を入力してください。"
        return redirect_to new_handout_path(:entry_id => params[:entry_id])
      end
      goods = Goods.new
      goods.price = params[:price].to_i
      goods.name = params[:name]
      goods.is_generic = false
      goods.save
      handout = Handout.new
      handout.entry_id = params[:entry_id]
      handout.goods_id = goods.id
      handout.save
    end
    flash[:success] = "頒布物を追加しました。"
    if params[:is_admin]
      redirect_to admin_entry_path(params[:entry_id])
    else
      redirect_to entry_path(params[:entry_id])
    end
  end
  def destroy
    handout = Handout.find_by_id(params[:id])
    handout.destroy
    flash[:success] = "頒布物を削除しました。"
    if params[:is_admin]
      redirect_to admin_entry_path(params[:entry_id])
    else
      redirect_to entry_path(params[:entry_id])
    end
  end
end
