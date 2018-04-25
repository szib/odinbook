module Contentlike
  extend ActiveSupport::Concern

  included do
    belongs_to :author, class_name: 'User'
    validates_presence_of :author
    validates_presence_of :content
  end

end
