class Employee < ApplicationRecord
  belongs_to :employer
  has_many :timesheets, dependent: :destroy
  has_many :budgets, through: :timesheets

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }

  def has_assoc_timesheets?
    timesheets.exists?
  # Employee.includes(:timesheets).where(timesheets: {employee_id: id}).any?
  end

  def assoc_timesheets_count
    if has_assoc_timesheets?
      return timesheets.count
    end
  end

  def assoc_budgets_count
    if has_assoc_timesheets?
      return budgets.distinct.count
    end
  end

end
