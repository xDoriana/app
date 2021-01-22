class Timesheet < ApplicationRecord
  belongs_to :employee
  belongs_to :budget

  validate :hours_are_within_budget_hours
  validate :hours_are_within_budget_hours_left
  validate :date_is_in_budget_date_range
  validates :hours, presence: true, numericality: { greater_than: 0 }

  # orele la timesheet sa nu depaseasca orele din buget + orele de la celelalte submitted timesheets

  def hours_are_within_budget_hours
    if hours > budget.hours
      errors.add(:hours, "do not fall within budget hours")
    end
  end

  def hours_are_within_budget_hours_left
    all_timesheets = Timesheet.where(budget_id: budget_id)
    #all_timesheets_hours = all_timesheets.sum(&:hours)

    if (hours + all_timesheets.sum(&:hours) > budget.hours) && (hours <= budget.hours)
      errors.add(:hours, "do not fall within budget hours left")
    end
  end

  def date_is_in_budget_date_range
    if date_of_service < budget.start_date || date_of_service > budget.end_date
      errors.add(:date_of_service, "does not fall in budget date range")
    end
  end

end
