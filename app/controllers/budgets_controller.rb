class BudgetsController < ApplicationController

    def index
        @budgets = Budget.all
    end

    def show
        @budget = Budget.find(params[:id])
        @employer = @budget.employer
        @timesheets = @budget.timesheets
        @employees = @budget.employees
    end

    def new
    end

    def edit
    end

    def destroy
    end
    
end
