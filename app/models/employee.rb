class Employee < ApplicationRecord
  belongs_to :employer
  has_many :timesheets, dependent: :destroy
  has_many :budgets, through: :timesheets

  validates :first_name, presence: true
  validates :last_name, presence: true

  def has_assoc_timesheets?
    Employee.includes(:timesheets).where(timesheets: {employee_id: id}).any?
# cum as putea face aici pt budgets folosind direct asocierea cu budgets?
  end
end
