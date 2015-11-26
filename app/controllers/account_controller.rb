class AccountController < ApplicationController

  before_action :authenticate_user!
  before_action :load_account
  
  def show
    session[:return_to] ||= request.referer
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def update
    if @account.update(account_params)
      flash[:notice] = "Account updated."
      redirect_to account_url
    else
      flash[:notice] = "Cannot update account."
      render 'show'
    end
  end

  private

  def account_params
    params.require(:user).permit(:first_name, :last_name, :notifications, :profile_image )
  end

  def load_account
    @account = current_user
  end

end
