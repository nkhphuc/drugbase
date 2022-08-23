module ProductsHelper
    def product_add_or_remove_button(drug, product)
        if product
            button_to "Remove Product", drug_product_path(drug, product), method: :delete, remote: true, class: "remove_product"
        else
            button_to "Add Product", drug_products_path(drug), remote: true, class: "add_product"
        end
    end
end
