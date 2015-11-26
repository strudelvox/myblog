class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	has_many :recordings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :webimages, dependent: :destroy

  accepts_nested_attributes_for :webimages

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    self.role == 1
  end

  def role_str
    case self.role
    when 1
      return 'admin'
    when 0
      return 'user'
    end
  end

  def status_str
    case self.status
    when 1
      return 'active'
    when 0
      return 'banned'
    end
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  scope :admins_count, -> { where('role = ?','1').count }

  def profile_image
    profile_webimage.image
  end

  def profile_image=(image)
    if image.present?
      profile_webimage.update(image: image)
    else
      profile_webimage.destroy
    end
  end

  def profile_webimage
    webimages.where(wi_type: 'profile').first || webimages.build(wi_type: 'profile')
  end

end

