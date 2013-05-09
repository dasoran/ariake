# coding: utf-8
class EntriesController < ApplicationController
  def index
    event = Event.find_by_name("C84") 
    @entries = Entry.find_all_by_event_id(event.id)
    def search
    end
  end 
  
  def show
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
  end

end
