class Employee < ApplicationRecord
  belongs_to :employer
  has_many :timesheets
  has_many :budgets, through: :timesheets
end
