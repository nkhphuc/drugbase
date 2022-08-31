class Post < ApplicationRecord

  belongs_to :user

  validates_presence_of :title

  enum status: {
    open: 0,
    closed: 1
  }

end
