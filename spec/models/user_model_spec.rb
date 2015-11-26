require 'rails_helper'

RSpec.describe "UserModelSpec" do

  it "having a valid factory" do
    user ||= create(:editor)
    expect(user).to be_valid
  end

  context "user's profile image test" do

    it "adds image to user" do
      user ||= create(:editor)
      # p user.first_name
      user.profile_image = File.open('app/assets/images/testimonial2.jpg')
      expect(Webimage.count).to be(1)
      expect(Webimage.first.image_file_name).to eq("testimonial2.jpg")
    end

    it "updates user's image" do
      user ||= create(:editor)
      # p user.first_name
      user.profile_image = File.open('app/assets/images/testimonial2.jpg')
      expect(Webimage.count).to be(1)
      user.profile_image = File.open('app/assets/images/testimonial3.jpg')
      expect(Webimage.first.image_file_name).to eq("testimonial3.jpg")
    end

  end

end