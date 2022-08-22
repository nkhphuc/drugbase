class Workplace < ApplicationRecord

    before_save :set_slug

    has_many :users, dependent: :destroy

    def to_param
        slug
    end

    scope :in_same_workplace, -> (user) { where("id = ?", user.workplace_id) }

    private

    def set_slug
        self.slug = name.parameterize
    end

end
