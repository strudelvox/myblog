class AdministerUsersController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin

  def edit
    @user = User.find(params[:id])
    session[:return_to] ||= request.referer
  end

  def index
    session[:return_to]=""
    session.delete(:return_to)
    @users = User.where.not(id: current_user.id).order("first_name ASC, last_name ASC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    render 'edit'
  end

  def update
    @user = User.find(params[:id])
    unless @user.admin? then
      if @user.update(administer_user_params)
        flash[:notice] = "User updated "
        if params[:send_email] == '1'
          AdminMailer.admin_to_user_email(@user).deliver_now
        end
        redirect_to administer_user_url(@user)
      else
        flash[:alert] = "Cannot update user"
        render 'edit'
      end
    else
      if (@user.admin? && User.admins_count > 1)
        # will update admin in case he is not last in system
        if @user.update(administer_user_params)
          flash[:notice] = "User with Admin role updated"
          redirect_to administer_user_url(@user)
        # last admin in the system cannot be changed!
        else
          flash[:alert] = "Cannot update last admin in system - use My Account to change alowed"
          render 'edit'
        end
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User destroyed."
    redirect_to administer_users_url
  end

  private

  def administer_user_params
    params.require(:user).permit(:id, :first_name, :last_name, :role, :status, :notifications, :message, :send_email, :profile_image )
  end

end
