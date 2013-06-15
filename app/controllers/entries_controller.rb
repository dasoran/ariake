# coding: utf-8
class EntriesController < ApplicationController
  def index
    event = Event.find_by_name("C84") 
    @entries = Entry.find_all_by_event_id(event.id)
    def search
      event = Event.find_by_name("C84")
      @entries = Entry.find_all_by_event_id(event.id)
      @entries = Entry.includes(:circle).where('circles.name LIKE ? OR circles.author LIKE ? OR entries.place LIKE ?','%'+params[:search_form]+'%','%'+params[:search_form]+'%','%'+params[:search_form]+'%')
      render "index"
    end
  end 
  
  def show
    @entry = Entry.find_by_id(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
    entry = Entry.find_by_id(params[:id])
    entry.destroy
    redirect_to entries_path, success: "削除しました。"
  end

end
