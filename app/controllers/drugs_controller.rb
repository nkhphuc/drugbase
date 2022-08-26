class DrugsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_drug, only: [:show, :edit, :update, :destroy]

    def index
        @drugs = Drug.all
    end

    def new
        @drug = Drug.new
    end

    def create
        @drug = Drug.new(drug_params)
        if @drug.save
            redirect_to drug_path(@drug), notice: "Drug successfully created!"
        else
            render :new, status: 422
        end
    end

    def show
        @workplaces = @drug.workplaces
        if current_workplace
            @product = current_workplace.products.find_by(drug_id: @drug.id)
        end
    end

    def edit
    end

    def update
        if @drug.update(drug_params)
            redirect_to drug_path(@drug), notice: "Drug successfully updated!"
        else
            render :edit, status: 422
        end
    end

    def destroy
        @drug.destroy
        redirect_to drugs_path, status: :see_other, alert: "Drug successfully deleted!"
    end

    private

    def set_drug
        @drug = Drug.find_by(registration_no: params[:id])
    end

    def drug_params
        params.require(:drug).permit(:name, :registration_no)
    end

end
