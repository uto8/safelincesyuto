class UserAllowance < ApplicationRecord
  belongs_to :user
  belongs_to :license
end
