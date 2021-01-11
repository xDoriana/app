class TimesheetsController < ApplicationController

    def index
        @timesheets = Timesheet.all
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
