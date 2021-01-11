class BudgetsController < ApplicationController

    def index
        @budgets = Budget.all
    end

    def show
    end

    def new
    end

    def edit
    end

    def destroy
    end
    
end
