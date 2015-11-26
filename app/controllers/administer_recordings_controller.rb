class AdministerRecordingsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin

  def show
    session[:return_to]=""
    session.delete(:return_to)
    @user_of_recs = User.find(params[:id])
    @user_recordings = Recording.where("user_id = ?", @user_of_recs).order("rec_approved ASC, created_at DESC").page(params[:page]).per(10)
  end

  def index
    session[:return_to]=""
    session.delete(:return_to)
    @recordings = Recording.order("rec_approved ASC, created_at DESC").page(params[:page]).per(10)
  end

end
