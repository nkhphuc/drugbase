class Product < ApplicationRecord
  belongs_to :drug
  belongs_to :workplace

  validates :drug_id, uniqueness: { scope: :workplace_id }

end
