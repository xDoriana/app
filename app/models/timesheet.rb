class Timesheet < ApplicationRecord
  belongs_to :employee
  belongs_to :budget

  validates :hours, :employee_id, :budget_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date_of_service, presence: true

  validate :employee_belongs_to_employer
  validate :hours_fit_in_a_day

  validate :hours_are_within_budget_hours
  validate :hours_are_within_budget_hours_left
  validate :date_is_in_budget_date_range


  # orele la timesheet sa nu depaseasca orele din buget + orele de la celelalte submitted timesheets

  def hours_are_within_budget_hours
    if hours > budget.hours
      errors.add(:hours, "do not fall within budget hours")
    end
  end

  def hours_are_within_budget_hours_left
    all_timesheets = Timesheet.where(budget_id: budget_id)
    # aici nu ia toate timesheet-urile, inclusiv asta curenta? sau le ia doar pe alea existente? ca atunci cand fac suma sa compar la if cu orele din buget, mai trebe sa pun si current hours sau nu?

    if (hours + all_timesheets.sum(&:hours) > budget.hours) && (hours <= budget.hours)
      errors.add(:hours, "do not fall within budget hours left")
    end
  end

  def date_is_in_budget_date_range
    if date_of_service < budget.start_date || date_of_service > budget.end_date
      errors.add(:date_of_service, "does not fall in budget date range")
    end
  end




  def employee_belongs_to_employer
    if employee.employer_id != budget.employer_id
      # sau daca fac has one through, sa pun != employer.id?
      errors.add(:employee_id, "and budget do not belong to the same employer")
    end
  end

  def hours_fit_in_a_day
    if hours > 24
      errors.add(:hours, "do not fit in a day")
    end
  end

end
