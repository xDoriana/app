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
    end

    def edit
    end

    def destroy
    end
    
end
