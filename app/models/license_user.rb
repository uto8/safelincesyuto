class LicenseUser < ApplicationRecord
  belongs_to :license
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :license_id
  # validationを修正
end
