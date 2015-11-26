class Webimage < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  belongs_to :comment
  has_attached_file :image, styles: { avatar: "64x64>", small: "128x96>", med: "512x384>", large: "1024x768>" }
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 1.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end
