class EmployeesController < ApplicationController

    def index
        @employees = Employee.all
    end

    def show
        @employee = Employee.find(params[:id])
        @employer = @employee.employer
        @timesheets = @employee.timesheets
        @budgets = @employee.budgets
        @first_budget = @budgets.order(:id).first
    end

    def new
        @employee = Employee.new
        @employer = Employer.new
    end

    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            flash[:success] = "Employee created"
            redirect_to employees_path
        else
            flash[:error] = "Employee was not created"
            render 'new'
        end
    end

    def edit
        @employee = Employee.find(params[:id])
        @employer = @employee.employer
    end

    def update
        @employee = Employee.find(params[:id])
        @employer = @employee.employer

        if @employee.update(employee_update_params)
            flash[:success] = "Employee updated"
            redirect_to employees_path
        else
            flash[:error] = "Employee was not updated"
            render 'edit'
        end
    end

    def destroy
    end

    private
    def employee_params
        params.require(:employee).permit(:employer_id, :first_name, :last_name)
    end

    def employee_update_params
        params.require(:employee).permit(:first_name, :last_name)
    end
    
end
