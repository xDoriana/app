class EmployersController < ApplicationController

    before_action :logged_in_user

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
            flash[:success] = "Employer created"
            redirect_to employers_path
        else
            flash[:error] = "Employer was not created"
            render 'new'
        end
    end

    def edit
        @employer = Employer.find(params[:id])
    end

    def update
        @employer = Employer.find(params[:id])
        if @employer.update(employer_params)
            flash[:success] = "Employer updated"
            redirect_to employers_path
        else
            flash[:error] = "Employer was not updated"
            render 'edit'
        end
    end

    def destroy
        @employer = Employer.find(params[:id]).destroy
        flash[:success] = "Employer and any associated records were deleted"
        redirect_to employers_path
    end
    

    private
        def employer_params
            params.require(:employer).permit(:first_name, :last_name)
        end
end
