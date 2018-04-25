class Comment < ApplicationRecord
  include Likeable
  include Contentlike

  belongs_to :post
end
