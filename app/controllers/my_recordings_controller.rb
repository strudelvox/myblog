class MyRecordingsController < ApplicationController

  before_action :authenticate_user!

  def index
    session[:return_to]=""
    session.delete(:return_to)
    @user_of_recs = current_user
    @user_recordings = Recording.where("user_id = ?",@user_of_recs).order("rec_approved ASC, created_at DESC").page(params[:page]).per(10)
  end

end
