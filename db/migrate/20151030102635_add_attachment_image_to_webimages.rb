class AddAttachmentImageToWebimages < ActiveRecord::Migration
  def self.up
    change_table :webimages do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :webimages, :image
  end
end
