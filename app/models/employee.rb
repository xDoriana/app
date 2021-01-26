class Employee < ApplicationRecord
  belongs_to :employer
  has_many :timesheets
  has_many :budgets, through: :timesheets

  validates :first_name, presence: true
  validates :last_name, presence: true
end
