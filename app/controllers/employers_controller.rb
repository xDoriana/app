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
        @employer = Employer.new
    end

    def create
        @employer = Employer.new(employer_params)
        if @employer.save
            flash[:notice] = "Employer created"
            redirect_to employers_path
        else
            render 'new'
        end
    end

    def edit
        @employer = Employer.find(params[:id])
    end

    def update
        @employer = Employer.find(params[:id])
        @employer.update(employer_params)
        flash[:notice] = "Employer updated"
        redirect_to employers_path
    end

    def destroy
    end
    

    private
        def employer_params
            params.require(:employer).permit(:first_name, :last_name)
        end
end
