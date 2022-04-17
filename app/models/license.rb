class License < ApplicationRecord
  validates :name, presence: true
  validates :fee, presence: true
end
