module DrugsHelper
    def product_in_index(drug)
        if current_workplace
            current_workplace.products.find_by(drug_id: drug.id)
        end
    end
end
