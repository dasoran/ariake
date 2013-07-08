# coding: utf-8
class Admin::ExecutorsController < Admin::Base
  def new
    @users = User.all
    @entry = Entry.find_by_id(params[:entry_id])

    @executors_hash = {}
    unless @entry.handouts[0].orders[0].executors.count == 0
      @entry.handouts[0].orders[0].executors.each do |executor|
        @executors_hash[executor.user.id] = true
      end
    end
  end
  def create
    @entry = Entry.find_by_id(params[:entry_id])
    @user = User.find_by_id(params[:user_id])
    
    if @entry.handouts.count == 0
      flash[:error] = "頒布物が登録されていません。"
      redirect_to admin_entry_path(@entry.id)
      return
    end
    if @entry.handouts[0].orders.count == 0
      flash[:error] = "希望者が一人もいません。"
      redirect_to admin_entry_path(@entry.id)
      return
    end
    
    unless @entry.handouts[0].orders[0].executors.count == 0
      @entry.handouts[0].orders[0].executors.each do |executor|
        if executor.user.id == @user.id
          flash[:error] = "すでに登録されています。"
          redirect_to admin_entry_path(@entry.id)
          return
        end
      end
    end

    @entry.handouts.each do |handout|
      handout.orders.each do |order|
        executor = Executor.new
        executor.user_id = @user.id
        executor.order_id = order.id
        executor.save
      end
    end
    flash[:success] = "購入者を追加しました。"
    redirect_to admin_entry_path(@entry.id)
  end
  def destroy
    @entry = Entry.find_by_id(params[:entry_id])
    @executor = Executor.find_by_id(params[:id])
    user = @executor.user

    @entry.handouts.each do |handout|
      handout.orders.each do |order|
        order.executors.each do |executor|
          next unless executor.user.id == user.id
          executor.destroy
        end
      end
    end

    flash[:success] = "購入者を削除しました。"
    redirect_to admin_entry_path(@entry.id)
  end
end
