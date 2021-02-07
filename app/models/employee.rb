class Employee < ApplicationRecord
  belongs_to :employer
  has_many :timesheets, dependent: :destroy
  has_many :budgets, through: :timesheets

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  def has_assoc_timesheets?
    Employee.includes(:timesheets).where(timesheets: {employee_id: id}).any?
# cum as putea face aici pt budgets folosind direct asocierea cu budgets?
  end
end
