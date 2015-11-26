class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  has_many :webimages, dependent: :destroy
  accepts_nested_attributes_for :webimages
end
