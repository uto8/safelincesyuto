class UserAllowance < ApplicationRecord
  belongs_to :user
  belongs_to :license

  def start_time
    self.date
  end
end
