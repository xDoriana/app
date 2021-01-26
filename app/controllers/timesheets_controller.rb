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
        @timesheet = Timesheet.new(timesheet_params)
        if @timesheet.save
            flash[:success] = "Timesheet created"
            redirect_to timesheets_path
        else
            flash[:error] = "Timesheet was not created"
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
