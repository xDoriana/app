class BudgetsController < ApplicationController

    def index
        @budgets = Budget.all
    end

    def show
        @budget = Budget.find(params[:id])
        @employer = @budget.employer
        @timesheets = @budget.timesheets
        @employees = @budget.employees
        @associated_timesheet_hours = @budget.associated_timesheets_hours
        @oldest_timesheet = @timesheets.order(:date_of_service).first
        @most_recent_timesheet = @timesheets.order(:date_of_service).last
        @first_employee = @employees.order(:id).first
# fa sa fie chestia asta mai optimizata
    end

    def new
        @budget = Budget.new
        @employer = Employer.new
    end

    def create
        @budget = Budget.new(budget_params)
        if @budget.save
            flash[:success] = "Budget created"
            redirect_to budgets_path
        else
            flash[:error] = "Budget was not created"
            render 'new'
        end
    end

    def edit
        @budget = Budget.find(params[:id])
        @employer = @budget.employer
    end

    def update
        @budget = Budget.find(params[:id])
        @employer = @budget.employer        

        if @budget.update(budget_update_params)
            flash[:success] = "Budget updated"
            redirect_to budgets_path
        else
            flash[:error] = "Budget was not updated"
            render 'edit'
            # respond_with(@budget)
        end
    end

    def destroy
        @budget = Budget.find(params[:id]).destroy
        flash[:success] = "Budget and any associated timesheets were deleted"
        redirect_to budgets_path
    end

    private
    def budget_params
        params.require(:budget).permit(:employer_id, :hours, :start_date, :end_date)
    end

    def budget_update_params
        params.require(:budget).permit(:hours, :start_date, :end_date)
    end
    
end
