class EmployersController < ApplicationController

    def index
        @employers = Employer.all
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
