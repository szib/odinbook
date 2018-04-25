class Comment < ApplicationRecord
  include Likeable

  belongs_to :post
  belongs_to :author, class_name: 'User'

  validates_presence_of :author
  validates_presence_of :content
end
