class Drug < ApplicationRecord

    has_many :products, dependent: :destroy
    has_many :workplaces, through: :products

    def to_param
        registration_no
    end

    validates :name, presence: true
    validates :registration_no, presence: true, uniqueness: true, format: { with: /^\S+$/, multiline: true }

end
