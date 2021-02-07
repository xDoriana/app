class Employer < ApplicationRecord
    has_many :employees, dependent: :destroy
    has_many :budgets, dependent: :destroy

    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }

    def has_assoc_budgets?
        Employer.includes(:budgets).where(budgets: {employer_id: id}).any?
# cum as putea face aici pt timesheets folosind direct asocierea cu timesheets (has many timesheets through budget)?
    end

    def has_assoc_employees?
        Employer.includes(:employees).where(employees: {employer_id: id}).any?
# cum as putea face aici pt timesheets folosind direct asocierea cu timesheets (has many timesheets through budget)?
    end

    # reports
    def total_budgets_hours
        budgets.sum(&:hours)
    end

    def timesheet_hours_from_budgets
        total_hours = 0
        budgets.each do |budget|
            total_hours += budget.timesheets.sum(&:hours)
        end
        return total_hours
    end

    def hours_usage_rate
        (timesheet_hours_from_budgets.to_f / total_budgets_hours.to_f * 100.0).round(2)
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
            total_days += (budget.end_date - budget.start_date).to_i
# nu-s sigura ca chestia asta takes into account DST
        end
        return total_days
    end

    def total_timesheets_number
        total_timesheets = 0
        budgets.each do |budget|
            total_timesheets += budget.timesheets.count
        end
        return total_timesheets
    end

    def days_usage_percentage
        (total_timesheets_number.to_f / budgets_total_days.to_f * 100.0).round(2)
    end


end
