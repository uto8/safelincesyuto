class LicenseUser < ApplicationRecord
  belongs_to :license
  belongs_to :user
end
