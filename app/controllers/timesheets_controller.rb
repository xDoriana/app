class TimesheetsController < ApplicationController

    def index
        @timesheets = Timesheet.all
    end

    def show
        @timesheet = Timesheet.find(params[:id])
        @employee = @timesheet.employee
        @employer = @employee.employer
    end

    def new
        @timesheet = Timesheet.new
        @employee = Employee.new
        @budget = Budget.new
    end

    def create
# an employee should only be able to submit a timesheet to an employer that she has a relationship with
# an employee should only be able to submit a timesheet with a date of service within the budgets’ start_date and end_date
# a timesheet should only be able to be submitted if there are enough hours left in the budget
# also, a timesheet shouldn't have more than 24 hrs
        @timesheet = Timesheet.new(timesheet_params)
        @employee = Employee.find(@timesheet.employee_id)
        @budget = Budget.find(@timesheet.budget_id)
        
        def enough_hours_in_budget?
            @all_timesheets = Timesheet.joins(:budget).where(:timesheets => {:budget_id => @budget.id})
            @hours = @all_timesheets.sum(&:hours)

            if @hours + @timesheet.hours <= @budget.hours
                return true
            else
                return false
            end
# ii ok boolean-ul asta?
        end

        if (@employee.employer_id == @budget.employer_id) && (@timesheet.date_of_service >= @budget.start_date && @timesheet.date_of_service <= @budget.end_date) && enough_hours_in_budget? && @timesheet.hours <= 24
            @timesheet.save
            flash[:notice] = "Timesheet created"
            redirect_to timesheets_path
        else
            flash[:warning] = "Employee and budget do not belong to the same employer / Timesheet does not fall in the budget date range / Not enough hours left in the budget / Timesheet exceeds 24 hours"
# fa mai multe mesaje de avertizare
            render 'new'
        end
    end

    def edit
        @timesheet = Timesheet.find(params[:id])
        @employee = @timesheet.employee
        @budget = @timesheet.budget
        @employer = @employee.employer
    end

    def update
        @timesheet = Timesheet.find(params[:id])
        @employee = @timesheet.employee
        @budget = @timesheet.budget
        @employer = @employee.employer

        if @timesheet.update(timesheet_update_params)
            flash[:success] = "Timesheet updated"
            redirect_to timesheets_path
        else
            flash[:error] = "Timesheet was not updated"
            render 'edit'
            # respond_with(@timesheet)
        end
    end

    def destroy
    end
    
    private
    def timesheet_params
        params.require(:timesheet).permit(:employee_id, :budget_id, :hours, :date_of_service)
    end

    def timesheet_update_params
        params.require(:timesheet).permit(:hours, :date_of_service)
    end

end
