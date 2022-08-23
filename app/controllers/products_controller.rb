class ProductsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_drug

    def create
        @drug.workplaces << current_workplace

        respond_to do |format|
            format.json { head :no_content }
            format.js   { render :layout => false }
         end

    end

    def destroy
        @product = current_workplace.products.find(params[:id])
        @product.destroy

        respond_to do |format|
            format.json { head :no_content }
            format.js   { render :layout => false }
         end

    end

    private

    def set_drug
        @drug = Drug.find_by!(registration_no: params[:drug_id])
    end

end
