require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

  it "emailing user when requesting password reset" do
    @user = create(:editor)
    visit new_user_session_path
    click_link "Forgot your password?"
    fill_in "Email", :with => @user.email
    click_button "Send me reset password instructions"
  	expect(current_path).to eq(new_user_session_path)
  	expect(last_email.to).to include(@user.email)
  	expect(last_email.subject).to eq("Reset password instructions")
  	expect(last_email.body.encoded).to include("Someone has requested a link to change your password, and you can do this through the link below")
  end

end
