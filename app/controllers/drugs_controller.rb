class DrugsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_drug, only: [:show, :edit, :update, :destroy]
    authorize_resource
    skip_authorize_resource only: [:index, :show]

    def index
        @drugs = Drug.all
    end

    def new
        @drug = Drug.new
    end

    def create
        @drug = Drug.new(drug_params)
        respond_to do |format|
            if @drug.save
                format.html { redirect_to drug_path(@drug), notice: "Drug successfully created!" }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def show
        if current_workplace
            @product = current_workplace.products.find_by(drug_id: @drug.id)
        end
    end

    def edit
    end

    def update
        respond_to do |format|
            if @drug.update(drug_params)
                format.html { redirect_to drug_path(@drug), notice: "Drug successfully updated!" }
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @drug.destroy

        respond_to do |format|
            format.html { redirect_to drugs_path, status: :see_other, alert: "Drug successfully deleted!" }
        end
    end

    private

    def set_drug
        @drug = Drug.find_by(registration_no: params[:id])
    end

    def drug_params
        params.require(:drug).permit(:name, :registration_no)
    end
end
