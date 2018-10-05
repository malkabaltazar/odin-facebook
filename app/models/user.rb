class User < ApplicationRecord
  has_many :notifications, dependent: :destroy
  has_many :sent_requests, class_name: 'Notification', as: :notifiable
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true

  def feed
    Post.where("user_id IN (?) OR user_id = ?", friend_ids, id)
  end

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    name = auth.info.name.split
    user.last_name = name.pop
    user.first_name = name.join(" ")
    user.birthday = "unknown"
    user.gender = "unknown"
    user.image = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
