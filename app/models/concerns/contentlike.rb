module Contentlike
  extend ActiveSupport::Concern

  included do
    belongs_to :author, class_name: 'User'
    validates_presence_of :author
    validates_presence_of :content
    validates :content, length: { minimum: 2, maximum: 1000 }

    scope :newest_first, -> { order(created_at: :desc) }
    scope :oldest_first, -> { order(created_at: :asc) }
  end

end
