require 'rails_helper'

RSpec.describe "RecordingSearch" do

  it "having a valid factory" do
    user ||= create(:editor)
    expect(create(:recording, user: user)).to be_valid
  end

 context "elastic search test", elasticsearch: true do

    it "getting some posts and searching them" do
      user ||= create(:editor)
      # p user.first_name
      user.recordings = create_list(:recording, 15, user: user)
      expect(user.recordings.count).to be(15)
      sleep 2

      resultset = user.recordings.search('txt',page: 2,per: 5)
      # resultset.each do |recording|
      #   p recording.rec_text
      # end
      expect(resultset.count).to be(5)

      resultset = user.recordings.search('text2_4')
      expect(resultset.count).to be(1)
    end

  end

end