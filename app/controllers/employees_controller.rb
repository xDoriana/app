class EmployeesController < ApplicationController

    def index
        @employees = Employee.all
    end

    def show
        @employee = Employee.find(params[:id])
        @employer = @employee.employer
        @timesheets = @employee.timesheets
        @budgets = @employee.budgets
    end

    def new
        @employee = Employee.new
        @employer = Employer.new
    end

    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            flash[:notice] = "Employee created"
            redirect_to employees_path
        else
            render 'new'
        end
    end

    def edit
    end

    def destroy
    end

    private
    def employee_params
        params.require(:employee).permit(:employer_id, :first_name, :last_name)
    end
    
end
