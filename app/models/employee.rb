class Employee < ApplicationRecord
  belongs_to :employer
  has_many :timesheets, dependent: :destroy
  has_many :budgets, through: :timesheets

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  def has_assoc_timesheets?
    timesheets.exists?
  #  Employee.includes(:timesheets).where(timesheets: {employee_id: id}).any?
# cum as putea face aici pt budgets folosind direct asocierea cu budgets? -- ce am vrut sa zic si aici? gen budgets.exists?, oare ca sa folosesc in view metoda asta?
  end

  def assoc_timesheets_count
    if has_assoc_timesheets?
      return timesheets.count
    end
  end

  def assoc_budgets_count
    if has_assoc_timesheets?
      return budgets.distinct.count('id')
    end
  end

end
