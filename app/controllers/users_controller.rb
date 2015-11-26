class UsersController < ApplicationController

  before_action :authenticate_user! 

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end 

end