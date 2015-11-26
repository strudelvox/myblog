class AdminMailer < ApplicationMailer
	
  def admin_to_user_email(user)
    @user = user
    mail(:to => @user.email,
    :subject => "From Admin of StrudelBLOG")
  end

end
