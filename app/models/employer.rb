class Employer < ApplicationRecord
    has_many :employees
    has_many :budgets

    validates :first_name, presence: true
    validates :last_name, presence: true
end
