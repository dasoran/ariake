# coding: utf-8
class CirclesController < ApplicationController
  def new
    @from = params[:from]
    @event_id = params[:event_id] if @from == "entries_new_searched"
  end
  def create
    if params[:circlename] == ""
      flash[:info] = "サークル名が空欄です。"
      return  redirect_to new_circle_path(:from => params[:from], :event_id => params[:event_id])
    end
 
    if params[:author] == ""
      flash[:info] = "作家が空欄です。"
      return  redirect_to new_circle_path(:from => params[:from], :event_id => params[:event_id])
    end
 
    circle = Circle.new
    circle.name = params[:circlename]
    circle.author = params[:author]
    circle.save

    flash[:success] = "%s を追加しました。" % circle.name
    if params[:from] == "entries_new_searched"
      if @current_user.permission == "admin"
        redirect_to new_searched_admin_entries_path(:event_id => params[:event_id])
      else
        redirect_to new_searched_entries_path(:event_id => params[:event_id])
      end
    else 
      redirect_to :root
    end
  end
end
