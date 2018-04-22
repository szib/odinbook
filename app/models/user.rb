class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy, autosave: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates_associated :profile
  validates_presence_of :profile

  accepts_nested_attributes_for :profile
end
