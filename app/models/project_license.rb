class ProjectLicense < ApplicationRecord
  belongs_to :project
  belongs_to :license
end
