class Budget < ApplicationRecord
  belongs_to :employer
  has_many :timesheets, dependent: :destroy
  has_many :employees, through: :timesheets

  validate :associated_timesheets_dates, on: :update
  validate :hours_cover_timesheets_hours
  validate :start_date_is_before_end_date
  validates :hours, presence: true, numericality: { greater_than: 0 }

  def timesheets_total_hours
    timesheets.sum(&:hours).to_i
  end

  def hours_cover_timesheets_hours
    if hours < timesheets_total_hours
      errors.add(:hours, "do not cover existing timesheets")
    end
  end

  def start_date_is_before_end_date
    if start_date > end_date
      errors.add(:start_date, "must be before or on the same day as end date")
    end
  end

  def has_assoc_timesheets?
    Budget.includes(:timesheets).where(timesheets: {budget_id: id}).any?
# cum as putea face aici pt employees folosind direct asocierea cu employees?
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


  # ce se intampla cu validarea asta daca nu am asociate timesheets??? si de ce nu merge cu metodele oldest_timesheet si most_recent_timesheet???
#   if has_assoc_timesheets? && oldest_timesheet > start_date
#   if has_assoc_timesheets? && most_recent_timesheet < end_date
end
