class Post < ApplicationRecord
  include Likeable
  include Contentlike

  has_many :comments, dependent: :destroy
end
