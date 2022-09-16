class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_drug
    authorize_resource

    def create
        @product = Product.create(drug: @drug, workplace: current_workplace)

        respond_to do |format|
            format.turbo_stream do
                flash.turbo[:notice] = "A product has been added to your workplace."
            end
        end
    end

    def destroy
        @product = @drug.products.find_by(workplace: current_workplace)
        @product.destroy
                                        
        respond_to do |format|
            format.turbo_stream do
                flash.turbo[:notice] = "A product has been removed from your workplace."
            end
        end
    end

    private

    def set_drug
        @drug = Drug.find_by(registration_no: params[:drug_id])
    end

    def product_params
        params.require(:product).permit(:drug_id, :workplace_id)
    end
end
