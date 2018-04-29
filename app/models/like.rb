class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates_presence_of :user
  validates_presence_of :likeable
end
