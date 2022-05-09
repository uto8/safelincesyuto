class Project < ApplicationRecord
  belongs_to :driver, optional: true
  belongs_to :leader, optional: true
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  accepts_nested_attributes_for :project_users, allow_destroy: true
  validates_associated :users
  has_many :project_licenses, dependent: :destroy
  has_many :licenses, through: :project_licenses
  accepts_nested_attributes_for :project_licenses, allow_destroy: true
  validates_associated :licenses
end
