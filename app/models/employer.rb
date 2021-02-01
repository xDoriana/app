class Employer < ApplicationRecord
    has_many :employees, dependent: :destroy
    has_many :budgets, dependent: :destroy

    validates :first_name, presence: true
    validates :last_name, presence: true

    def has_assoc_budgets?
        Employer.includes(:budgets).where(budgets: {employer_id: id}).any?
# cum as putea face aici pt timesheets folosind direct asocierea cu timesheets (has many timesheets through budget)?
    end

    def has_assoc_employees?
        Employer.includes(:employees).where(employees: {employer_id: id}).any?
# cum as putea face aici pt timesheets folosind direct asocierea cu timesheets (has many timesheets through budget)?
    end
end
