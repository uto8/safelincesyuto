class Project < ApplicationRecord
  belongs_to :driver, optional: true
  belongs_to :leader, optional: true
end
