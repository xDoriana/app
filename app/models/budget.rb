class Budget < ApplicationRecord
  belongs_to :employer
  has_many :timesheets, dependent: :destroy
  has_many :employees, through: :timesheets

  validate :associated_timesheets_dates, on: :edit
  validate :hours_cover_timesheets_hours
  validate :start_date_is_before_end_date
  validates :hours, presence: true, numericality: { greater_than: 0 }

  def associated_timesheets_hours
    timesheets.sum(&:hours)
  end

  def hours_cover_timesheets_hours
    if hours < associated_timesheets_hours
      errors.add(:hours, "do not cover existing timesheets")
    end
  end

  def start_date_is_before_end_date
    if start_date > end_date
      errors.add(:start_date, "must be before end date")
    end
  end

  def associated_timesheets_dates
    timesheets_dates = timesheets.order(:date_of_service)
    oldest_timesheet = timesheets_dates.first
    most_recent_timesheet = timesheets_dates.last

    if oldest_timesheet.date_of_service < start_date
      errors.add(:start_date, "does not cover timesheet dates")
    end

    if most_recent_timesheet.date_of_service > end_date
      errors.add(:end_date, "does not cover timesheet dates")
    end
  end

  def has_assoc_timesheets?
    Budget.includes(:timesheets).where(timesheets: {budget_id: id}).any?
# cum as putea face aici pt employees folosind direct asocierea cu employees?
  end

end
