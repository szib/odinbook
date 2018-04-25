class Post < ApplicationRecord
  include Likeable

  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  validates_presence_of :author
  validates_presence_of :content
end
