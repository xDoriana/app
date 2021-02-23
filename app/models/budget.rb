class Budget < ApplicationRecord
  belongs_to :employer
  has_many :timesheets, dependent: :destroy
  has_many :employees, through: :timesheets

  validates :hours, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :start_date, :end_date, :employer_id, presence: true

  validate :hours_cover_timesheets_hours
  validate :start_date_is_before_end_date
  validate :associated_timesheets_dates, on: :update

  def timesheets_total_hours
    timesheets.sum(&:hours).to_i
  end

  def hours_usage_rate
    (timesheets_total_hours.to_f / hours.to_f * 100.0).round(2)
  end

  def hours_cover_timesheets_hours
    return unless hours
    # mai trebe sa verific si daca exista timesheets?

    if hours < timesheets_total_hours
      errors.add(:hours, "do not cover existing timesheets")
    end
  end

  def start_date_is_before_end_date
    return unless start_date && end_date
    # sau scriu return unless budget??
    
    if start_date > end_date
      errors.add(:start_date, "must come before or be on the same day as end date")
    end
  end

  def has_assoc_timesheets?
    timesheets.exists?
#   timesheets.any?
#   Budget.includes(:timesheets).where(timesheets: {budget_id: id}).any?
# cum as putea face aici pt employees (adica employees.exists? oare?) folosind direct asocierea cu employees? -- ce am vrut sa zic?? oare ca sa folosesc in view metoda asta?
  end

  def assoc_timesheets_count
    if has_assoc_timesheets?
      return timesheets.count
    end
  end

  def assoc_employees_count
    if has_assoc_timesheets?
      return employees.distinct.count('id')
    end
  end

  def oldest_timesheet
    if has_assoc_timesheets?
      timesheet = timesheets.order(:date_of_service).first
      timesheet.date_of_service
    end
  end

  def most_recent_timesheet
    if has_assoc_timesheets?
      timesheet = timesheets.order(:date_of_service).last
      timesheet.date_of_service
    end
  end


  def associated_timesheets_dates
    if has_assoc_timesheets? && oldest_timesheet < start_date
      errors.add(:start_date, "does not cover timesheet dates")
    end

    if has_assoc_timesheets? && most_recent_timesheet > end_date
      errors.add(:end_date, "does not cover timesheet dates")
    end
  end

  # ce se intampla cu validarea asta daca nu am asociate timesheets??? ce imi returneaza?
  
# si de ce nu merge cu metodele oldest_timesheet si most_recent_timesheet??? -- nuj ce ii cu chestia asta, oare e obsolete?
#   if has_assoc_timesheets? && oldest_timesheet > start_date
#   if has_assoc_timesheets? && most_recent_timesheet < end_date
end
