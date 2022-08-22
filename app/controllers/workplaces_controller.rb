class WorkplacesController < ApplicationController

    before_action :require_signin
    before_action :require_correct_workplace, only: :show

    def index
        @workplaces = Workplace.in_same_workplace(current_user)
    end

    def show
        @users = @workplace.users
    end

    private

    def require_correct_workplace
        @workplace = Workplace.find_by(slug: params[:id])
        redirect_to root_path unless current_workplace?(@workplace)
    end

end
