class Drug < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :search_by_all, against: [:registration_no, :name], using: {
        tsearch: {prefix: true, any_word: true},
        trigram: {
            threshold: 0.3,
            word_similarity: true
        }
    }

    has_many :products, dependent: :destroy
    has_many :workplaces, through: :products

    def to_param
        registration_no
    end

    validates :name, presence: true
    validates :registration_no, presence: true, uniqueness: true, format: { with: /^\S+$/, multiline: true }

end
