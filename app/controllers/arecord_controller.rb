class ArecordController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :new, :create, :update, :destroy, :preview]
  before_action :check_user_status, only: [:new, :create, :destroy] 

  def preview
    session[:return_to]=""
    session.delete(:return_to)
    @rec = Recording.find(params[:id])
  end

  def show
    session[:return_to]=""
    session.delete(:return_to)
    @rec = Recording.find(params[:id])
    @rec.rec_hits += 1
    @rec.save
  end

  def edit
    @rec = Recording.find(params[:id])
    session[:return_to] ||= request.referer
  end

  def new     
    @rec = Recording.new
  end

  def create
    @rec = Recording.new(arecord_params)
    @rec.user_id = current_user.id
    if @rec.save
      unless current_user.admin?
        @rec.update(:rec_approved => 0)
        flash[:notice] = "Record created, approve pending."
      end
      flash[:notice] = "Record created."
      redirect_to my_recordings_url
    else
      flash[:alert] = "Cannot create record."
      render 'edit'
    end
  end

  def update
    @rec = Recording.find(params[:id]) 
    if @rec.update(arecord_params)
      unless current_user.admin?
        @rec.update(:rec_approved => 0)
        flash[:notice] = "Record updated, approve pending."
      end
      flash[:notice] = "Record updated."
      if session[:return_to]
        redirect_to session[:return_to]
      else
        redirect_to arecord_url(@rec)
      end
    else
      flash[:alert] = "Cannot update record."
      render 'edit'
    end
  end

  def destroy
    @rec = Recording.find(params[:id])
    if current_user.admin? || @rec.rec_approved != 1 
      @rec.destroy
      flash[:notice] = "Record destroyed."
    end
    if current_user.admin?
      redirect_to administer_recordings_url
    else
      redirect_to recordings_url
    end
  end

  private

  def arecord_params
    params.require(:recording).permit(:id, :rec_header, :rec_teaser, :rec_text, :rec_approved)
  end

end
