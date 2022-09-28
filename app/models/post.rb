class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_all, against: [:title, :content], using: {
    tsearch: {prefix: true, any_word: true},
    trigram: {
      threshold: 0.3,
      word_similarity: true
    }
  }
  
  belongs_to :user

  validates_presence_of :title

  enum status: {
    open: 0,
    closed: 1
  }
end
