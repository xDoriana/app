class Timesheet < ApplicationRecord
  belongs_to :employee
  belongs_to :budget
  has_one :employer, through: :employee
  has_one :employer, through: :budget

  validates :hours, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :employee_id, :budget_id, :date_of_service, presence: true

#  validate :employee_belongs_to_employer // oare asta o folosesc prin view undeva????
  validate :hours_are_within_budget_hours
  validate :hours_are_within_budget_hours_left
  validate :hours_fit_in_a_day
  validate :date_is_in_budget_date_range

  def hours_are_within_budget_hours
    return unless hours && budget

    if hours > budget.hours
      errors.add(:hours, "do not fall within budget hours")
    end
  end

  def hours_are_within_budget_hours_left
#   all_timesheets = Timesheet.where(budget_id: budget_id)
    return unless hours && budget

    all_timesheets = budget.timesheets
    if (hours + all_timesheets.sum(&:hours) > budget.hours) && (hours <= budget.hours)
      errors.add(:hours, "do not fall within budget hours left")
    end
  end

  def hours_fit_in_a_day
    return unless hours

    if hours > 24
      errors.add(:hours, "do not fit in a day")
    end
  end

  def date_is_in_budget_date_range
    return unless date_of_service && budget
    if date_of_service < budget.start_date || date_of_service > budget.end_date
      errors.add(:date_of_service, "does not fall in budget date range")
    end
  end

  # def employee_belongs_to_employer
  #   if employee.employer_id != budget.employer_id
  #     # sau daca fac has one through, sa pun != employer.id?
  #     errors.add(:employee_id, "and budget do not belong to the same employer")
  #   end
  # end

  # CUM FAC SA MA ASIGUR CA EMPLOYEE SI BUDGET IS DE LA ACELASI EMPLOYER CAND E CREAT UN TIMESHEET?
  # ce se intampla de ex daca un hacker da un post/patch request direct cu datele de modificat, fara formular, si pune employer si budget de la diferiti employers? cum ma asigur ca nu se intampla aia?
end
