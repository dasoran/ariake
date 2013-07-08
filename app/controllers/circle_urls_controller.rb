# coding: utf-8
class CircleUrlsController < ApplicationController
  def create
    circle_url = CircleUrl.new
    entry = Entry.find_by_id(params[:entry_id])

    circle_url.circle_id = entry.circle.id
    circle_url.page_url = "http://"
    circle_url.page_attr = "web"

    present_master_url = CircleUrl.where(circle_id: entry.circle.id, is_master_url: true).first
    circle_url.is_master_url = present_master_url.nil?
    circle_url.save
    flash[:success] = "URLを追加しました。"
    if @current_user.administrator
      redirect_to edit_admin_entry_path(params[:entry_id])
    else
      redirect_to edit_entry_path(params[:entry_id])
    end
  end
  def destroy
    circle_url = CircleUrl.find_by_id(params[:id])
    circle_url.destroy
    circle_url.save
    flash[:success] = "URLを削除しました。"
    if @current_user.administrator
      redirect_to edit_admin_entry_path(params[:entry_id])
    else
      redirect_to edit_entry_path(params[:entry_id])
    end
  end
end
