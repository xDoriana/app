class Employer < ApplicationRecord
    has_many :employees, dependent: :destroy
    has_many :budgets, dependent: :destroy
    has_many :timesheets, through: :employees
    has_many :timesheets, through: :budgets

    validates :first_name, :last_name, presence: true, length: { maximum: 50 }

    def has_assoc_budgets?
        budgets.exists?
    end

    def assoc_budgets_count
        if has_assoc_budgets?
          return budgets.count
        end
    end

    def has_assoc_employees?
        employees.exists?
    end

    def assoc_employees_count
        if has_assoc_employees?
          return employees.count
        end
    end

    # reports
    def total_budgets_hours
        budgets.sum(&:hours)
    end

    def timesheets_hours_from_budgets_hours
        timesheets.sum(&:hours)
    end

    def budgets_hours_usage_rate
        (timesheets_hours_from_budgets_hours.to_f / total_budgets_hours.to_f * 100.0).round(2)
    end

    def budgets_start_date
        budget = budgets.order(:start_date).first
        return budget.start_date
    end

    def budgets_end_date
        budget = budgets.order(:end_date).last
        return budget.end_date
    end

    def budgets_total_days
        total_days = 0
        budgets.each do |budget|
            total_days += (budget.end_date - budget.start_date).to_i + 1
			# not sure if this takes into account DST
        end
        return total_days
    end

    def has_assoc_timesheets?
        timesheets.exists?
    end

    def assoc_timesheets_count
        if has_assoc_timesheets?
            return timesheets.count
        end
    end
end
