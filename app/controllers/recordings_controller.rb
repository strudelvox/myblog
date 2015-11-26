class RecordingsController < ApplicationController

  def index
    session[:return_to]=""
    session.delete(:return_to)
    @recordings = Recording.approved.order("created_at DESC").page(params[:page]).per(5)
  end

end
