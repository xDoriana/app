class EmployeesController < ApplicationController

    def index
        @employees = Employee.all
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
