class Budget < ApplicationRecord
  belongs_to :employer
  has_many :timesheets
end
