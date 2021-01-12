class Budget < ApplicationRecord
  belongs_to :employer
  has_many :timesheets
  has_many :employees, through: :timesheets
end
