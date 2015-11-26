class RegistrationsController < Devise::RegistrationsController

  def destroy
    unless current_user.admin?
      if current_user.destroy
        flash[:notice] = "User deleted."
        redirect_to root_url
      end
    else
      flash[:notice] = "Admin user cannot be deleted."
      redirect_to root_url
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :role, :email, :password, :password_confirmation)
  end                                                                                                       
  
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

end