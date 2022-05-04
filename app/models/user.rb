class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  has_many :license_users
  has_many :licenses, through: :license_users
  accepts_nested_attributes_for :license_users, allow_destroy: true
  validates_associated :licenses
  # validationを修正
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
end
