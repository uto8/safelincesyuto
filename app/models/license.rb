class License < ApplicationRecord
  validates :name, presence: true
  validates :fee, presence: true
  has_many :license_users
  has_many :users, through: :license_users
end
