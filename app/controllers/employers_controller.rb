class EmployersController < ApplicationController

    def index
        @employers = Employer.all
    end

    def show
        @employer = Employer.find(params[:id])
    end

    def new
    end

    def edit
    end

    def destroy
    end
    
end
