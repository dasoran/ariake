# coding: utf-8

class Admin::EventsController < Admin::Base
  def inhibit_input
    @event = Event.find_by_id(params[:id])
    @event.is_inhibit = true
    @event.save
    redirect_to admin_user_path
  end
  def stop_to_inhibit
    @event = Event.find_by_id(params[:id])
    @event.is_inhibit = false
    @event.save
    redirect_to admin_user_path
  end
end
