class User < ApplicationRecord
  has_many :notifications, dependent: :destroy
  has_many :sent_requests, class_name: 'Notification', as: :notifiable
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
end
