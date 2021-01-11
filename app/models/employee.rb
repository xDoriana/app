class Employee < ApplicationRecord
  belongs_to :employer
  has_many :timesheets, through: :budget
end
