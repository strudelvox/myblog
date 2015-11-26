require 'rails_helper'

RSpec.describe "EditUser", type: :request do

  it "editing user banning him and sending him an email" do
    @user = create(:editor)
    @admin = create(:admin)

  # p @user.id
  # p @user.first_name
  # p @admin.id
  # p @admin.first_name

    visit new_user_session_path
    fill_in "Email", :with => @admin.email
    fill_in "Password", :with => @admin.password
    click_button "Sign in"
    expect(current_path).to eq(recordings_path)
    click_link "Admin"
    click_link "Manage users"
    expect(current_path).to eq(administer_users_path)

    click_link "Edit user"
    expect(current_path).to eq(edit_administer_user_path(@user.id))
    expect(find_field("First name").value).to match(/user\d+_myFirstName/)

    fill_in "user_first_name", :with => "Ivan"
    expect(find_field("First name").value).to eq("Ivan")

    fill_in "user_last_name", :with => "Ivanov"
    expect(find_field("Last name").value).to eq("Ivanov")

    select "user", :from => "user_role"
    fill_in "user_message", :with => "Banned for bad words"
    choose("user_status_0")
    check("user_notifications")
    check("send_email")

    attach_file "user_profile_image", "app/assets/images/testimonial2.jpg"

    click_button "formSave"

    expect(page).to have_content("User updated")
    expect(current_path).to eq(administer_user_path(@user.id))
    expect(find_field("First name").value).to eq("Ivan")

    @user.reload
    @admin.reload

  # p @user.id
  # p @user.first_name
  # p @admin.id
  # p @admin.first_name

    expect(@user.first_name).to eq("Ivan")
    expect(@user.profile_image.url).to match(/.*testimonial2.jpg.*/)
    expect(Webimage.count).to be(1)
    expect(Webimage.first.image_file_name).to eq("testimonial2.jpg")

    expect(last_email.to).to include(@user.email)
    expect(last_email.subject).to eq("From Admin of StrudelBLOG")
    expect(last_email.body.encoded).to include("Banned for bad words")
  end

end