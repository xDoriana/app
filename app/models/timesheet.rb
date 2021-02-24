class Timesheet < ApplicationRecord
  belongs_to :employee
  belongs_to :budget
  has_one :employer, through: :employee
  has_one :employer, through: :budget

  validates :hours, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :employee_id, :budget_id, :date_of_service, presence: true

  validate :employee_and_budget_belong_to_same_employer
  validate :hours_are_within_budget_hours
  validate :hours_are_within_budget_hours_left
  validate :hours_fit_in_a_day
  validate :date_is_in_budget_date_range

  def hours_are_within_budget_hours
    return unless hours && budget

    if hours > budget.hours
      errors.add(:hours, "do not fall within budget hours. Budget hours: #{budget.hours}")
    end
  end

  def hours_left
    return unless budget

    all_timesheets = budget.timesheets
    hours_left = budget.hours - all_timesheets.sum(&:hours)
    return hours_left
  end

  def hours_are_within_budget_hours_left
#   all_timesheets = Timesheet.where(budget_id: budget_id)
    return unless hours && budget

    if ( hours > hours_left) && (hours <= budget.hours)
      errors.add(:hours, "do not fall within budget hours left. Hours left: #{hours_left}")
    end
  end

  def hours_fit_in_a_day
    return unless hours

    if hours > 24
      errors.add(:hours, "do not fit in a current day on Earth. You must have come from the future or a different planet, you advanced workaholic being, you! Does this mean the end of our childhood, master Overlord? Also, do you get enough sleep?")
    end
  end

  def date_is_in_budget_date_range
    return unless date_of_service && budget

    if date_of_service < budget.start_date || date_of_service > budget.end_date
      errors.add(:date_of_service, "does not fall in budget date range. Budget date range: #{budget.start_date} - #{budget.end_date}")
    end
  end

  def employee_and_budget_belong_to_same_employer
    return unless employee && budget

     if employee.employer_id != budget.employer_id
      errors.add(:employee, "and budget do not belong to the same employer")
    end
  end
end
