class License < ApplicationRecord
  validates :title, presence: true
  validates :fee, presence: true
  has_many :license_users
  has_many :users, through: :license_users
  has_many :project_licenses
  has_many :projects, through: :project_licenses
end
