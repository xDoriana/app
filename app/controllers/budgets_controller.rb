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
        @budget = Budget.new
        @employer = Employer.new
    end

    def create
        @budget = Budget.new(budget_params)
        if @budget.start_date < @budget.end_date
            @budget.save
            flash[:notice] = "Budget created"
            redirect_to budgets_path
        else
            flash[:warning] = "Budget start date should come before end date"
            render 'new'
        end
    end

    def edit
    end

    def destroy
    end

    private
    def budget_params
        params.require(:budget).permit(:employer_id, :hours, :start_date, :end_date)
    end
    
end
