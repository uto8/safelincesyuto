class LicenseUser < ApplicationRecord
  belongs_to :license
  belongs_to :user
  validates :user_id, uniqueness: { scope: :license_id } 
end
