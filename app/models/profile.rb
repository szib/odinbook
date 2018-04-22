class Profile < ApplicationRecord
  before_save :capitalize_names

  belongs_to :user

  validates :first_name, :last_name, length: { minimum: 2, maximum: 50 }

  def capitalize_names
    self.first_name.capitalize!
    self.last_name.capitalize!
    self.location.capitalize!
  end
end
