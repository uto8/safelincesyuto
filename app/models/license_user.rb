class LicenseUser < ApplicationRecord
  belongs_to :license
  belongs_to :user
  validates :license_id, uniqueness: { scope: :user_id }
end
