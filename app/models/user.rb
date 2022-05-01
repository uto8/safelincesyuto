class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  has_many :license_users
  has_many :licenses, through: :license_users
  # accepts_nested_attributes_for :licenses, allow_destroy: true
  validates_associated :licenses
end
