class EmployersController < ApplicationController

    def index
        @employers = Employer.all
    end

    def show
        @employer = Employer.find(params[:id])
        @employees = @employer.employees
        @budgets = @employer.budgets
    end

    def new
    end

    def edit
    end

    def destroy
    end
    
end
