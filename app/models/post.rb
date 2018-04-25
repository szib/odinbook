class Post < ApplicationRecord
  include Likeable

  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
end
