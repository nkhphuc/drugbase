class ProductsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_drug

    def create
        @drug.workplaces << current_workplace
    end

    def destroy
        @product = current_workplace.products.find(params[:id])
        @product.destroy
    end

    private

    def set_drug
        @drug = Drug.find_by!(registration_no: params[:drug_id])
    end

end
