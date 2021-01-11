class Employer < ApplicationRecord
    has_many :employees
    has_many :budgets
end
