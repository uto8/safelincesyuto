class Project < ApplicationRecord
  belongs_to :driver, optional: true
  belongs_to :leader, optional: true
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  accepts_nested_attributes_for :project_users, allow_destroy: true
  validates_associated :projects
end
