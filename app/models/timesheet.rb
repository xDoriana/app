class Timesheet < ApplicationRecord
  belongs_to :employee
  belongs_to :budget
end
